const express = require('express');
const bodyParser = require('body-parser');
const axios = require('axios');
const cors = require('cors');

const app = express();
app.use(bodyParser.json());
app.use(cors({ origin: '*' }));

// In-memory store of all events
const events = [];

app.post('/events', async (req, res) => {
  const event = req.body;
  events.push(event);
  console.log('Incoming Event', event.type);

  try {
    await Promise.all([
      // fan out to each service by its Kubernetes service name
      axios.post('http://posts:8001/events', event),
      axios.post('http://comments:8002/events', event),
      axios.post('http://query:8003/events', event),
      axios.post('http://moderation:8004/events', event),
    ]);

    // all forwards succeeded
    return res.status(200).send({});
  } catch (err) {
    console.error('Error forwarding event:', err.message);
    return res.status(500).json({ error: err.message });
  }
});

app.get('/events', (req, res) => {
  res.status(200).json(events);
});

const PORT = 8005;
app.listen(PORT, () => {
  console.log(`Event bus listening on http://0.0.0.0:${PORT}`);
});
