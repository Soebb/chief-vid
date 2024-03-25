#!/bin/sh
cd /apps
docker run -d --privileged --name mydind docker:dind
docker exec -it mydind docker date
docker build -t boehmls/chief-video:latest .
docker run --rm -v /app/videos:/app/videos -p 5000:5000 -e "VIDEO_URL=/app/videos" boehmls/chief-video:latest

