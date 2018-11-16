FROM alpine:latest

# Install mysql client and python+git for s3cmd
RUN apk update && \
    apk add python py-pip py-setuptools git ca-certificates mariadb-client && \
    rm -rf /var/cache/apk/* && \
    pip install python-dateutil && \
    git clone https://github.com/s3tools/s3cmd.git /opt/s3cmd && \
    ln -s /opt/s3cmd/s3cmd /usr/bin/s3cmd

# s3cmd config file (base only - will be updated when container starts from entrypoint.sh)
COPY ./s3cfg.base /tmp/s3cfg

# Include the entrypoint script+tasks make them executable
COPY entrypoint.sh /tmp/
RUN chmod +x /tmp/entrypoint.sh

COPY backup /opt/tasks/
RUN chmod -R +x /opt/tasks

VOLUME ["/snapshots"]

ENTRYPOINT ["/tmp/entrypoint.sh"]

# Default command is to run cron in the foreground
CMD ["crond", "-f", "-d", "8"]

