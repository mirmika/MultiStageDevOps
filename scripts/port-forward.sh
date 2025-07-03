#!/bin/bash

kubectl port-forward svc/kuma-uptime-service -n kuma-monitoring 5005:3001 --address='0.0.0.0' &
echo "Kuma Uptime Dashboard: http://172.28.198.57:5005/"

kubectl port-forward svc/comments-nodeport-prod -n production 31201:8002 --address='0.0.0.0' &
echo "Comments Service Dashboard: http://172.28.198.57:31201/"

kubectl port-forward svc/ingress-nginx-controller -n ingress-nginx 7080:80 --address='0.0.0.0' &
echo "Ingress Controller: http://172.28.198.57:7080/"

wait
