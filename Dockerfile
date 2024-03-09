FROM alpine:latest

ARG USER=root
USER $USER

WORKDIR /app

COPY . ./

EXPOSE 5000
RUN chmod +x /app/start.sh
ENTRYPOINT ["./start.sh"]
