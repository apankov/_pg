docker_run() {
    cmd=$1
    mapping=$2

    docker run -it --link $DOCKER_POSTGRESQLD_CONTAINER:postgres $mapping --rm postgres sh -c "PGPASSWORD=${DBPASS} exec ${cmd}"

#    docker run -it --link postgresqld:postgres --rm \
#                    postgres sh -c 'exec psql -h "$POSTGRES_PORT_5432_TCP_ADDR" -p "$POSTGRES_PORT_5432_TCP_PORT" -U postgres '$DBNAME
#cmd: psql -h192.168.99.100  -P5432 -upostgres -plinux --default-character-set=utf8 shiptify
}

run_postgresql_cmd() {
    cmd=$1
    mapping=$2
    if [ $DOCKER_POSTGRESQLD_CONTAINER ]; then
        docker_run "${cmd}" "${mapping}"
    else
        bash -c "$cmd"
    fi
}

port=''
if [ "${DBPORT}" ]; then
    port=" -p ${DBPORT}"
fi
POSTGRESQL_CMD="psql -h ${DBHOST} ${port} -U ${DBUSER} "
