#!/bin/bash

# Kuma Uptime Dashboard
kubectl port-forward svc/kuma-uptime-service -n kuma-monitoring 3005:3001 --address='0.0.0.0' &
echo "Kuma Uptime: http://172.28.198.57:3005/"

# Comments service
kubectl port-forward svc/comments-nodeport-dev -n development 3006:8002 --address='0.0.0.0' &
echo "Comments: http://172.28.198.57:3006/"

# Event Bus service
kubectl port-forward svc/event-bus-nodeport-dev -n development 3007:8005 --address='0.0.0.0' &
echo "Event-bus: http://172.28.198.57:3007/events"

# Query service
kubectl port-forward svc/query-nodeport-dev -n development 3008:8003 --address='0.0.0.0' &
echo "Query: http://172.28.198.57:3008/posts"

# Posts service
kubectl port-forward svc/post-nodeport-dev -n development 3009:8001 --address='0.0.0.0' &
echo "Posts: http://172.28.198.57:3009/post"

# Moderation service
kubectl port-forward svc/moderation-nodeport-dev -n development 3010:8004 --address='0.0.0.0' &
echo "Moderation: http://172.28.198.57:3010/"

# Ingress controller
kubectl port-forward svc/ingress-nginx-controller -n ingress-nginx 8080:80 --address='0.0.0.0' &
echo "Ingress Controller: http://172.28.198.57:8080/"

wait
