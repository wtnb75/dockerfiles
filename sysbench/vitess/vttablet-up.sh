#!/bin/bash
. $(dirname $0)/env.sh

set -u

keyspace=${KEYSPACE:-'test_keyspace'}
shard=${SHARD:-'0'}
uid=$1
shift
tablet_role=${1-master}
shift

als=$(printf '%s-%010d' $CELL $uid)
tablet_dir=$(printf 'vt_%010d' $uid)

init_db_sql_file="$VTROOT/init_db.sql"
echo "GRANT ALL ON *.* TO 'root'@'%';" > $init_db_sql_file
echo "GRANT ALL ON *.* TO 'vt_dba'@'%';" >> $init_db_sql_file
echo "GRANT ALL ON *.* TO 'vt_app'@'%';" >> $init_db_sql_file
echo "GRANT ALL ON *.* TO 'vt_repl'@'%';" >> $init_db_sql_file

if [ "$tablet_role" = "master" ]; then
    echo "CREATE DATABASE vt_$keyspace;" >> $init_db_sql_file
fi

export EXTRA_MY_CNF=$VTROOT/config/mycnf/master_mysql56.cnf

mkdir -p $VTDATAROOT/backups

echo "Starting MySQL for tablet..."
action="init -init_db_sql_file $init_db_sql_file"
if [ -d $VTDATAROOT/$tablet_dir ]; then
  echo "Resuming from existing vttablet dir:"
  echo "    $VTDATAROOT/$tablet_dir"
  action='start'
fi

export KEYSPACE=$keyspace
export SHARD=$shard
export TABLET_ID=$als
export TABLET_DIR=$tablet_dir
export MYSQL_PORT=3306
export TABLET_TYPE=$tablet_role

$VTROOT/bin/mysqlctl \
  -log_dir $VTDATAROOT/tmp \
  -tablet_uid $uid \
  -mysql_port 3306 \
  $action &

wait

$VTROOT/bin/vtctl $TOPOLOGY_FLAGS AddCellInfo -root vitess/$CELL -server_address consul1:8500 $CELL

$VTROOT/bin/vtctl $TOPOLOGY_FLAGS CreateKeyspace $keyspace
$VTROOT/bin/vtctl $TOPOLOGY_FLAGS CreateShard $keyspace/$shard

$VTROOT/bin/vtctl $TOPOLOGY_FLAGS InitTablet -shard $shard -keyspace $keyspace -allow_master_override $als $tablet_role

echo "Starting vttablet..."
exec $VTROOT/bin/vttablet \
  $TOPOLOGY_FLAGS \
  -logtostderr=true \
  -tablet-path $als \
  -tablet_hostname "" \
  -health_check_interval 5s \
  -enable_semi_sync \
  -enable_replication_reporter \
  -port $WEB_PORT \
  -grpc_port $GRPC_PORT \
  -service_map 'grpc-queryservice,grpc-tabletmanager,grpc-updatestream' \
  -pid_file $VTDATAROOT/$tablet_dir/vttablet.pid \
  -vtctld_addr "http://vtctld:$WEB_PORT/"
