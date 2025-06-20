#!/bin/bash

kubectl port-forward svc/kuma-uptime-service -n kuma-monitoring 3005:3001 --address='0.0.0.0' &
echo "Kuma Uptime: http://172.28.198.57:3005/"

kubectl port-forward svc/ingress-nginx-controller -n ingress-nginx 8060:80 --address='0.0.0.0' &
echo "Ingress Controller: http://172.28.198.57:8060/"

wait
