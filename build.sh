#!/bin/bash

docker buildx build --platform linux/amd64 -f docker/Dockerfile -t  ghcr.io/loopcap/assettoserver:latest . --no-cache
docker push ghcr.io/loopcap/assettoserver:latest
