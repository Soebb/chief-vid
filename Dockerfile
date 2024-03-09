FROM boehmls/chief-video:latest
RUN --rm --it -v /app/videos:/app/videos -p 5000:5000 -e "VIDEO_URL=/app/videos"
