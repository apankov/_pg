#!/bin/bash

DIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DBCONF=$DIR/db.conf

if [ ! -f $DBCONF ]; then
    echo "unable to open config file ${DBCONF}"
    exit 1
fi

. $DBCONF
. $DIR/lib.sh



docker run \
    -it \
    --link $DOCKER_POSTGRESQLD_CONTAINER:postgres \
    --rm \
    postgres sh -c 'exec pg_dump -h "$POSTGRES_PORT_5432_TCP_ADDR" -p "$POSTGRES_PORT_5432_TCP_PORT" -U postgres '$DBNAME


# docker run \
# 	-it \
# 	--name postgres-console \
# 	--link postgresqld:postgres \
# 	--rm \
# 	-d \
# 	postgres
