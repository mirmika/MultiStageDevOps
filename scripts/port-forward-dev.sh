#!/bin/bash

# Kuma Uptime Dashboard
kubectl port-forward svc/kuma-uptime-service -n kuma-monitoring 5005:3001 --address='0.0.0.0' &
echo "Kuma Uptime: http://172.28.198.57:5005/"

# Ingress controller
kubectl port-forward svc/ingress-nginx-controller -n ingress-nginx 9080:80 --address='0.0.0.0' &
echo "Ingress Controller: http://172.28.198.57:9080/"

wait
