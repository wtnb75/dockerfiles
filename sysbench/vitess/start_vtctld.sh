#! /bin/sh
. $(dirname $0)/env.sh

exec vtctld $TOPOLOGY_FLAGS \
  -cell $CELL \
  -web_dir $VTTOP/web/vtctld \
  -web_dir2 $VTTOP/web/vtctld2/app \
  -workflow_manager_init \
  -workflow_manager_use_election \
  -service_map 'grpc-vtctl' \
  -backup_storage_implementation file \
  -file_backup_storage_root $VTDATAROOT/backups \
  -logtostderr \
  -port $WEB_PORT \
  -grpc_port $GRPC_PORT \
  -pid_file /tmp/vtctld.pid
