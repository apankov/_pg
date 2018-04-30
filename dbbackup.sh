#!/bin/bash

DIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DBCONF=$DIR/db.conf

if [ ! -f $DBCONF ]; then
    echo "unable to open config file ${DBCONF}"
    exit 1
fi

. $DBCONF
. $DIR/lib.sh


now=`date +'%Y-%m-%d_%H-%M-%S'`



docker run \
    -it \
    --link $DOCKER_POSTGRESQLD_CONTAINER:postgres \
    --rm \
    postgres sh -c 'exec pg_dump -h "$POSTGRES_PORT_5432_TCP_ADDR" -p "$POSTGRES_PORT_5432_TCP_PORT" -U '$DBUSER' '$DBNAME > $DBNAME-$now.sql



# PGPASSWORD="$DBPASS" pg_dump -h $DBHOST -U $DBUSER $DBNAME > $DBNAME-$now.sql

bzip2 -9    $DBNAME-$now.sql

