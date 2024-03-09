FROM ubuntu:bionic
ARG DEBIAN_FRONTEND=noninteractive

ARG USER=root
USER $USER

RUN apt-get update && apt-get -y install curl sudo

RUN curl -fsSL https://get.docker.com -o get-docker.sh && \
    sudo sh get-docker.sh

WORKDIR /app

COPY . ./

EXPOSE 5000

RUN chmod +x /app/start.sh
ENTRYPOINT ["./start.sh"]
