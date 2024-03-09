FROM ubuntu:bionic
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get -y install curl sudo

RUN curl -fsSL https://get.docker.com -o get-docker.sh && \
    sudo sh get-docker.sh
RUN sudo apt-get update && apt-get -y install docker-compose
WORKDIR /app

COPY . ./

EXPOSE 5000

RUN chmod +x /app/start.sh
ENTRYPOINT ["./start.sh"]
