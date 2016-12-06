docker_run() {
    cmd=$1
    mapping=$2

    docker run -it --link $DOCKER_POSTGRESQLD_CONTAINER:postgres $mapping --rm postgres sh -c "exec ${cmd}"
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
