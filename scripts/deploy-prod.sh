#!/bin/bash

helm upgrade --install client      charts/client      -n production -f environments/prod/client-values.yaml
helm upgrade --install posts        charts/post        -n production -f environments/prod/post-values.yaml
helm upgrade --install comments    charts/comments    -n production -f environments/prod/comments-values.yaml
helm upgrade --install query       charts/query       -n production -f environments/prod/query-values.yaml
helm upgrade --install moderation  charts/moderation  -n production -f environments/prod/moderation-values.yaml
helm upgrade --install event-bus   charts/event-bus   -n production -f environments/prod/event-bus-values.yaml
helm upgrade --install ingress     charts/ingress     -n production -f environments/prod/ingress-values.yaml
