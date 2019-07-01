#! /bin/zsh

typeset -g -A scr
scr=(
  cockroach19 cockroach
  mariadb10 mysql
  mysql56 mysql
  mysql57 mysql
  mysql8 mysql
  percona8 mysql
  tidb tidb
  postgres9 pgsql
  postgres10 pgsql
  postgres11 pgsql
  postgres12 pgsql
)

for y in compose/*.yml ; do
  bn=$(basename $y .yml)
  if [ -z "${scr[${bn}]}" ]; then
    echo "${scr[${bn}]} not found"
    continue
  fi
  for t in 1 $(seq 2 2 10) ; do
    [ -f ${bn}.${t}.log ] && continue
    sh dotest.sh ${y} run_${scr[${bn}]}.sh ${t}
  done
done
