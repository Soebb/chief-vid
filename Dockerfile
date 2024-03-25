FROM ubuntu:latest

RUN curl -fsSL https://get.docker.com -o get-docker.sh && sh get-docker.sh
WORKDIR /apps

COPY . ./

EXPOSE 5000

RUN chmod +x /apps/start.sh
ENTRYPOINT ["./start.sh"]
