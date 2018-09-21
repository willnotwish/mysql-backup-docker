FROM alpine:latest

# Note that the script name should *not* have any extension
# https://wiki.alpinelinux.org/wiki/Alpine_Linux:FAQ#My_cron_jobs_don.27t_run.3F

COPY backup /etc/periodic/15min/

RUN apk update && \
    apk upgrade && \
    apk add --no-cache mariadb-client && \
    rm -rf /var/cache/apk/* && \
    chmod a+x /etc/periodic/15min/*
