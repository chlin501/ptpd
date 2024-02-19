ARG image_version=latest
FROM debian:${image_version}
WORKDIR /ptpd
LABEL "Author"="Chia-Hung Lin"

RUN apt-get update
COPY ./src/ptpd2 /ptpd/
COPY ./test/client-e2e-socket.conf /ptpd/
COPY ./start /ptpd/

ENTRYPOINT ["/ptpd/start"]
