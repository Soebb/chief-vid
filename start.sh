#!/bin/sh
cd /app
docker build -t boehmls/chief-video:latest .
docker run --privileged --rm -v /app/videos:/app/videos -p 5000:5000 -e "VIDEO_URL=/app/videos" boehmls/chief-video:latest
sudo dockerd
