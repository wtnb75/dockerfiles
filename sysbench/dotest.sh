#! /bin/sh
# Usage: $0 compose/xxx.yml run_script.sh threads

yaml=$1
shift
runscr=$1
shift
threads=$1
shift

bn=$(basename ${yaml} .yml)

[ -f "${yaml}" ] || exit 1
[ -n "${threads}" ] || exit 1

args="-f docker-compose.yml -f ${yaml}"

set -x

docker-compose ${args} up -d
docker-compose ${args} exec -T client sh ${runscr} waitfor
docker-compose ${args} exec -T client sh ${runscr} prepare
docker-compose ${args} exec -T client sh ${runscr} run ${threads} > ${bn}.${threads}.log 2> ${bn}.${threads}.err
[ -s ${bn}.${threads}.err ]  || rm ${bn}.${threads}.err
docker-compose ${args} down -v
docker system prune --volumes -f
