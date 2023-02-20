#!/bin/bash
case $1 in
"namenode")
  PORT="$(hdfs getconf -confKey "dfs.namenode.http-address" | awk -F : '{print $2}')"
  ;;
"datanode")
  PORT="$(hdfs getconf -confKey "dfs.datanode.http.address" | awk -F : '{print $2}')"
  ;;
"secondarynamenode")
  PORT="$(hdfs getconf -confKey "dfs.namenode.secondary.http-address" | awk -F : '{print $2}')"
  ;;
"historyserver")
  PORT="$(hdfs getconf -confKey "mapreduce.jobhistory.webapp.address" | awk -F : '{print $2}')"
  ;;
"journalnode")
  PORT="$(hdfs getconf -confKey "dfs.journalnode.http-address" | awk -F : '{print $2}')"
  ;;
"zkfc")
  PORT="$(hdfs getconf -confKey "dfs.ha.zkfc.port")"
  ;;
"resourcemanager")
  PORT="$(hdfs getconf -confKey "yarn.resourcemanager.webapp.address" | awk -F : '{print $2}')"
  ;;
"nodemanager")
  PORT="$(hdfs getconf -confKey "yarn.nodemanager.webapp.address" | awk -F : '{print $2}')"
  ;;
esac
nc -z localhost "$PORT"
