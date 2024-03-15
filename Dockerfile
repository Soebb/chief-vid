FROM python:3.10-slim-bullseye

RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get install -y ffmpeg

RUN pip install --no-cache-dir https://github.com/Soebb/docker-run-cmd/archive/main.zip gunicorn Flask python-dotenv Flask-WTF Flask-Session ffprobe-python

WORKDIR /apps

COPY . ./

EXPOSE 5000

RUN chmod +x /apps/start.sh
ENTRYPOINT ["./start.sh"]
