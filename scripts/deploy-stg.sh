#!/bin/bash

helm upgrade --install client      charts/client      -n staging -f environments/stg/client-values.yaml
helm upgrade --install post        charts/post        -n staging -f environments/stg/post-values.yaml
helm upgrade --install comments    charts/comments    -n staging -f environments/stg/comments-values.yaml
helm upgrade --install query       charts/query       -n staging -f environments/stg/query-values.yaml
helm upgrade --install moderation  charts/moderation  -n staging -f environments/stg/moderation-values.yaml
helm upgrade --install event-bus   charts/event-bus   -n staging -f environments/stg/event-bus-values.yaml
helm upgrade --install ingress     charts/ingress     -n staging -f environments/stg/ingress-values.yaml
