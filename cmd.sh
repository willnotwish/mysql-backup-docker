#!/bin/sh

echo "Setting up s3cmd config now..."

CFG=/tmp/s3cfg

echo "s3cmd config file base: $CFG"

echo "access_key = ${S3_BACKUP_ACCESS_KEY}" >> $CFG
echo "secret_key = ${S3_BACKUP_SECRET_ACCESS_KEY}" >> $CFG
echo "host_base = ${S3_BACKUP_ENDPOINT}" >> $CFG
echo "host_bucket = %(bucket)s.${S3_BACKUP_ENDPOINT}" >> $CFG

echo "Moving config $CFG into place"
mv $CFG /root/.s3cfg

echo "s3cmd ls output"
echo `s3cmd ls`

echo "s3cmd config setup complete. Starting cron in the foreground"

crond -f -d 8

