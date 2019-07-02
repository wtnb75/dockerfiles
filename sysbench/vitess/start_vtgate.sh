#! /bin/sh
. $(dirname $0)/env.sh

exec vtgate $TOPOLOGY_FLAGS \
  -logtostderr \
  -port $WEB_PORT \
  -grpc_port $GRPC_PORT \
  -mysql_server_port $MYSQL_PORT \
  -mysql_auth_server_impl none \
  -cell $CELL \
  -cells_to_watch $CELL \
  -tablet_types_to_wait MASTER,REPLICA \
  -gateway_implementation discoverygateway \
  -service_map 'grpc-vtgateservice' \
  -pid_file /tmp/vtgate.pid
