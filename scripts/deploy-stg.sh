
#!/bin/bash
helm upgrade --install post charts/post -f environments/stg/post-values.yaml
helm upgrade --install comments charts/comments -f environments/stg/comments-values.yaml
helm upgrade --install query charts/query -f environments/stg/query-values.yaml
helm upgrade --install moderation charts/moderation -f environments/stg/moderation-values.yaml
helm upgrade --install event-bus charts/event-bus -f environments/stg/event-bus-values.yaml
