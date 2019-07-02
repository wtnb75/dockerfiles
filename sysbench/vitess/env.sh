CELL=test
KEYSPACE=test_keyspace
WEB_PORT=8080
GRPC_PORT=15999
MYSQL_PORT=15306

#TOPOLOGY_FLAGS="-topo_implementation zk2 -topo_global_server_address zoo1 -topo_global_root /vitess/global"
TOPOLOGY_FLAGS="-topo_implementation consul -topo_global_server_address consul1:8500 -topo_global_root vitess/global"
