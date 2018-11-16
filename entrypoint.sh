#!/bin/sh

# Exit on fail
set -e

echo "entrypoint.sh: Setting up backup config now..."

CFG=/tmp/s3cfg

echo "s3cmd config file base: $CFG"

echo "access_key = ${S3_ACCESS_KEY}" >> $CFG
echo "secret_key = ${S3_SECRET_ACCESS_KEY}" >> $CFG
echo "host_base = ${S3_ENDPOINT}" >> $CFG
echo "host_bucket = %(bucket)s.${S3_ENDPOINT}" >> $CFG

echo "Moving config $CFG into place"
mv $CFG /root/.s3cfg

echo "entrypoint.sh: s3cmd version: $(s3cmd --version) configured."

echo "entrypoint.sh: Symlinking tasks. SNAPSHOT_FREQUENCY: $SNAPSHOT_FREQUENCY"

# Note that the script name should *not* have any extension
# https://wiki.alpinelinux.org/wiki/Alpine_Linux:FAQ#My_cron_jobs_don.27t_run.3F
ln -s /opt/tasks/backup /etc/periodic/$SNAPSHOT_FREQUENCY/backup
echo "entrypoint.sh: Tasks: $(ls -al /etc/periodic/$SNAPSHOT_FREQUENCY)"

echo "entrypoint.sh: About to run command $@"

exec "$@"

