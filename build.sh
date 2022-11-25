#!/bin/bash
docker buildx create --use --name myalidns
docker buildx build --no-cache --tag scjtqs/alidns-webhook:0.1.1   --platform linux/amd64,linux/arm64 --push .
docker buildx rm myalidns
