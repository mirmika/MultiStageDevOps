
#!/bin/bash
helm upgrade --install post charts/post -f environments/prod/post-values.yaml
helm upgrade --install comments charts/comments -f environments/prod/comments-values.yaml
helm upgrade --install query charts/query -f environments/prod/query-values.yaml
helm upgrade --install moderation charts/moderation -f environments/prod/moderation-values.yaml
helm upgrade --install event-bus charts/event-bus -f environments/prod/event-bus-values.yaml
