
# README

This backup service uses mysqldump to take a snapshot of the database, which it then compresses (using gzip) and uploads (using s3cmd) to an S3 bucket.

It also uploads a file "latest" which contains the name of the last snapshot taken.

The following environment variables need to be set
    - S3_ACCESS_KEY
    - S3_SECRET_ACCESS_KEY
    - S3_ENDPOINT
    - S3_BUCKET (default: striders)
    - S3_BUCKET_PREFIX (default: backups)
    - MYSQL_DATABASE (default: striders)
    - MYSQL_USER (default: striders)
    - MYSQL_PASSWORD (required)
    - SNAPSHOT_FREQUENCY (15min/hourly/daily/weekly - default: daily)
    - LOG_VERBOSITY (default: 8)


