FROM ubuntu-bionic-systemd-docker:latest

WORKDIR /apps

COPY . ./

EXPOSE 5000

RUN chmod +x /apps/start.sh
ENTRYPOINT ["./start.sh"]
