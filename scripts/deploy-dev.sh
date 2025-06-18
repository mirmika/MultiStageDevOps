#!/bin/bash

helm upgrade --install client      charts/client      -n development -f environments/dev/client-values.yaml
helm upgrade --install post        charts/post        -n development -f environments/dev/post-values.yaml
helm upgrade --install comments    charts/comments    -n development -f environments/dev/comments-values.yaml
helm upgrade --install query       charts/query       -n development -f environments/dev/query-values.yaml
helm upgrade --install moderation  charts/moderation  -n development -f environments/dev/moderation-values.yaml
helm upgrade --install event-bus   charts/event-bus   -n development -f environments/dev/event-bus-values.yaml
helm upgrade --install ingress     charts/ingress     -n development -f environments/dev/ingress-values.yaml

