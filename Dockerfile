FROM ubuntu:bionic
ARG DEBIAN_FRONTEND=noninteractive

ARG USER=root
USER $USER
#RUN python3 -m venv venv
RUN apt-get update && apt-get -y install docker-ce
WORKDIR /app

COPY . ./

EXPOSE 5000
RUN chmod +x /app/start.sh
ENTRYPOINT ["./start.sh"]
