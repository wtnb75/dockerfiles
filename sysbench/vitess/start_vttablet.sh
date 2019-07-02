#! /bin/sh
. $(dirname $0)/env.sh
d=$(dirname $0)
args="-logtostderr"

uid=${1-1}
if [ "$uid" = "1" ] ; then
  role=master
else
  role=replica
fi

uid10=$(printf "%010d" $uid)
al=test-${uid10}

mkdir -p /tmp/x
set -x

if [ -d /vt/vtdataroot/vt_${uid10} ]; then
  mysqlctl -log_dir /tmp/x -tablet_uid ${uid} -mysql_port 3306 start
else
  mysqlctl -log_dir /tmp/x -tablet_uid ${uid} -mysql_port 3306 init -init_db_sql_file ${d}/init_${role}.sql
fi

vtctl $TOPOLOGY_FLAGS $args AddCellInfo -root vitess/test -server_address zoo1 test
vtctl $TOPOLOGY_FLAGS $args CreateKeyspace $TEST_KEYSPACE
vtctl $TOPOLOGY_FLAGS $args CreateShard $TEST_KEYSPACE/0
vtctl $TOPOLOGY_FLAGS $args InitTablet -shard 0 -keyspace $TEST_KEYSPACE -allow_master_override $al $role

vttablet $TOPOLOGY_FLAGS $args \
  -tablet-path $al \
  -tablet_hostname "" \
  -health_check_interval 5s \
  -enable_semi_sync \
  -enable_replication_reporter \
  -port $WEB_PORT \
  -grpc_port $GRPC_PORT \
  -service_map 'grpc-queryservice,grpc-tabletmanager,grpc-updatestream' \
  -pid_file /tmp/vttablet.pid \
  -vtctld_addr "http://vtctld:8080/"
