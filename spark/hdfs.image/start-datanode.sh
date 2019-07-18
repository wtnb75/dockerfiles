#! /bin/sh
# Usage: $0 hdfs://namenode

fs=${1-hdfs://namenode}
shift

exec hdfs datanode -fs ${fs} $*
