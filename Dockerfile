FROM python:3.10-slim-bullseye

RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get install -y ffmpeg curl git sudo

RUN RUN curl -sSL https://get.docker.com/ | sh
RUN apt-get update && apt-get -y install docker-compose

WORKDIR /apps
COPY . ./

RUN pip install --no-cache-dir git+https://github.com/Soebb/docker-run-cmd.git gunicorn Flask python-dotenv Flask-WTF Flask-Session ffprobe-python

RUN adduser -u 5678 --disabled-password --gecos "" appuser && chown -R appuser /apps
USER appuser

EXPOSE 5000

RUN chmod +x /apps/start.sh
ENTRYPOINT ["./start.sh"]
