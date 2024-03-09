FROM ubuntu:bionic
ARG DEBIAN_FRONTEND=noninteractive

ARG USER=root
USER $USER

RUN apt-get update && apt-get -y install curl

RUN curl -fsSLO https://get.docker.com/builds/Linux/x86_64/docker-25.0.4-ce.tgz && \
    tar xzvf docker-25.0.4-ce.tgz && \
    mv docker/docker /usr/local/bin && \
    rm -r docker docker-25.0.4-ce.tgz

WORKDIR /app

COPY . ./

EXPOSE 5000

RUN chmod +x /app/start.sh
ENTRYPOINT ["./start.sh"]
