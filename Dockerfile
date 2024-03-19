FROM python:3.10-slim-bullseye

RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get install -y ffmpeg

WORKDIR /apps
COPY . ./

RUN pip install podman-compose

EXPOSE 5000

RUN chmod +x /apps/start.sh
ENTRYPOINT ["./start.sh"]
