#!/bin/bash

# Start docker
start-docker.sh

# Your commands go here
cd /apps
docker service restart
docker build -t boehmls/chief-video:latest .
docker run --privileged -v /run/user/1000/docker.sock:/run/user/1000/docker.sock ubuntu-dind docker run --rm -v /run/user/1000/docker.sock:/run/user/1000/docker.sock -v /app/videos:/app/videos -p 5000:5000 -e "VIDEO_URL=/app/videos" boehmls/chief-video:latest
#docker run --privileged ubuntu-dind docker compose up
docker service restart
