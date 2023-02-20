#!/bin/bash

# 启动SSH Daemon
echo "启动SSH服务"
sudo /sbin/sshd

# 初始化zookeeper
echo "检查初始化状态"
MY_ID="$(echo "$HOSTNAME" | awk -F "-" '{print $NF}')"
DATA_DIR="$(grep 'dataDir' "$ZOOKEEPER_HOME"/conf/zoo.cfg | awk -F "=" '{print $2}')"
if [ ! -f "${DATA_DIR}/myid" ]; then
  mkdir -p "$DATA_DIR"
  echo "$MY_ID" >"$DATA_DIR"/myid
fi

# 启动zookeeper
echo "启动zookeeper服务"
"$ZOOKEEPER_HOME/bin/zkServer.sh" "start-foreground"
