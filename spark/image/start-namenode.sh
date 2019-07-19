#! /bin/sh
# Usage: $0 fs

basedir=/tmp/hadoop-root/dfs/name/current/
fs=${1-hdfs://$(hostname)}
shift

[ -f ${basedir}/VERSION ] || hdfs namenode -format -fs ${fs} $*

exec hdfs namenode -fs ${fs} $*
