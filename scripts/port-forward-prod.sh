#!/bin/bash

kubectl port-forward svc/kuma-uptime-service -n kuma-monitoring 6005:3001 --address='0.0.0.0' &
echo "Kuma Uptime: http://172.28.198.57:6005/"

kubectl port-forward svc/comments-nodeport-prod -n production 6006:8002 --address='0.0.0.0' &
echo "Comments: http://172.28.198.57:6006/"

kubectl port-forward svc/event-bus-nodeport-prod -n production 6007:8005 --address='0.0.0.0' &
echo "Event-bus: http://172.28.198.57:6007/events"

kubectl port-forward svc/query-nodeport-prod -n production 6008:8003 --address='0.0.0.0' &
echo "Query: http://172.28.198.57:6008/posts"

kubectl port-forward svc/post-nodeport-prod -n production 6009:8001 --address='0.0.0.0' &
echo "Posts: http://172.28.198.57:6009/post"

kubectl port-forward svc/moderation-nodeport-prod -n production 6010:8004 --address='0.0.0.0' &
echo "Moderation: http://172.28.198.57:6010/"

kubectl port-forward svc/ingress-nginx-controller -n ingress-nginx 7080:80 --address='0.0.0.0' &
echo "Ingress Controller: http://172.28.198.57:7080/"

wait
