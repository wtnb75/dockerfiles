#! /bin/sh

port=4000
args="/usr/local/share/sysbench/oltp_read_write.lua --db-driver=mysql --table-size=1000000 --mysql-host=db --mysql-port=${port} --mysql-user=root --time=60 --db-ps-mode=disable --auto-inc=off"

waitfor(){
  /wait-for -it db:${port}
}

prepare(){
  echo "CREATE DATABASE sbtest;" | mysql -uroot -P${port} -hdb
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
