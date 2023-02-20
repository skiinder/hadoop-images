#!/bin/bash

# 启动SSH Daemon
echo "启动SSH服务"
sudo /sbin/sshd

# 启动Hadoop服务
case $1 in
"namenode")
  "$HADOOP_HOME/bin/hdfs" namenode
  ;;
"datanode")
  "$HADOOP_HOME/bin/hdfs" datanode
  ;;
"secondarynamenode")
  "$HADOOP_HOME/bin/hdfs" secondarynamenode
  ;;
"historyserver")
  "$HADOOP_HOME/bin/mapred" historyserver
  ;;
"journalnode")
  "$HADOOP_HOME/bin/hdfs" journalnode
  ;;
"zkfc")
  "$HADOOP_HOME/bin/hdfs" zkfc
  ;;
"resourcemanager")
  "$HADOOP_HOME/bin/yarn" resourcemanager
  ;;
"nodemanager")
  "$HADOOP_HOME/bin/yarn" nodemanager
  ;;
"init_namenode")
  set -x
  MY_ID="$(echo "$HOSTNAME" | awk -F "-" '{print $NF}')"
  if [ "$(hdfs getconf -confKey "dfs.nameservices")" ]; then
    # 初始化HA集群
    if [ "$MY_ID" = '0' ]; then
      "$HADOOP_HOME/bin/hdfs" namenode -format -nonInteractive
      "$HADOOP_HOME/bin/hdfs" zkfc -formatZK -nonInteractive
      exit 0
    else
      "$HADOOP_HOME/bin/hdfs" namenode -bootstrapStandby -nonInteractive
      exit 0
    fi
  else
    # 初始化非HA集群
    if [ "$MY_ID" = '0' ]; then
      "$HADOOP_HOME/bin/hdfs" namenode -format -nonInteractive
      exit 0
    else
      echo "非HA模式不应该有一台以上的Namenode"
      exit 1
    fi
  fi
  ;;
*)
  /bin/ttyd -o /bin/bash
  ;;
esac
