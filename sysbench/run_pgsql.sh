#! /bin/sh

port=5432
args="/usr/local/share/sysbench/oltp_read_write.lua --db-driver=pgsql --table-size=1000000 --pgsql-host=db --pgsql-password=sbtest --time=60 --db-ps-mode=disable"

waitfor(){
  /wait-for -it db:${port}
}

prepare(){
  sysbench $args prepare
}

run(){
  local threads=${1-1}
  sysbench $args --threads=${threads} run
}

cmd=${1}
shift

case "${cmd}" in
  prepare|waitfor|run)
    ${cmd} $*
    ;;
  *)
    echo "Usage: $0 [waitfor|run|prepare]"
    ;;
esac
