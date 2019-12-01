#!/bin/bash
#
# Build our Docker container
#

# Errors are fatal
set -e

pushd $(dirname $0)/.. > /dev/null

echo "# "
echo "# Building container..."
echo "# "
docker build . -f bin/Dockerfile-2-backup-tweets -t twitter-metrics-backup-tweets

ARGS="$@"
if test "$1" == "bash"
then
	ARGS="bash"

else
	ARGS="2-backup-tweets $@"

fi

docker run -it -e "S3=${S3}" -v $(pwd):/mnt twitter-metrics-backup-tweets ${ARGS}

