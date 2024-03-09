FROM ubuntu:bionic
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get -y install curl sudo

RUN curl -fsSL https://get.docker.com -o get-docker.sh && \
    sudo sh get-docker.sh
RUN sudo apt-get update && apt-get -y install docker-compose
RUN docker run -v /var/run/docker.sock:/var/run/docker.sock
WORKDIR /app

COPY . ./

EXPOSE 5000

RUN chmod +x /app/start.sh
ENTRYPOINT ["./start.sh"]
