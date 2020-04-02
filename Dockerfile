FROM alpine:latest

RUN apk add git torsocks wget sed

COPY crontab /etc/cron/crontab

RUN crontab /etc/cron/crontab

CMD ["crond", "-f"]
