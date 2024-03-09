FROM ubuntu:bionic
ARG DEBIAN_FRONTEND=noninteractive

ARG USER=root
USER $USER

RUN apt-get update && apt-get -y install curl

RUN curl -A "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36" -fsSLO https://test.docker.com/builds/Linux/x86_64/docker-25.0.4-ce.tgz && \
    tar xzvf docker-25.0.4-ce.tgz && \
    mv docker/docker /usr/local/bin && \
    rm -r docker docker-25.0.4-ce.tgz

WORKDIR /app

COPY . ./

EXPOSE 5000

RUN chmod +x /app/start.sh
ENTRYPOINT ["./start.sh"]
