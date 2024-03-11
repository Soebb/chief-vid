FROM ubuntu:bionic
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get -y install curl sudo

RUN RUN curl -sSL https://get.docker.com/ | sh
RUN apt-get update && apt-get -y install docker-compose

WORKDIR /apps

COPY . ./

EXPOSE 5000

RUN chmod +x /apps/start.sh
ENTRYPOINT ["./start.sh"]
