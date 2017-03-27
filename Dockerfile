FROM alpine:3.5
MAINTAINER Fco. Javier Delgado del Hoyo <frandelhoyo@gmail.com>

RUN apk add --update bash rsync && rm -rf /var/cache/apk/* && mkdir /backup

ENV CRON_TIME="0 0 * * 7"
VOLUME ["/backup", "/target"]

COPY ["run.sh", "backup.sh", "/"]
RUN chmod u+x /backup.sh

CMD ["/run.sh"]
