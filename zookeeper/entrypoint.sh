#!/bin/bash
# 启动SSH Daemon
sudo /sbin/sshd

# 初始化zookeeper
MY_ID="$(echo "$HOSTNAME" | awk -F "-" '{print $NF}')"
DATA_DIR="$(grep 'dataDir' "$ZOOKEEPER_HOME"/conf/zoo.cfg | awk -F "=" '{print $2}')"
mkdir -p "$DATA_DIR"
echo "$MY_ID" > "$DATA_DIR"/myid

# 启动zookeeper
"$ZOOKEEPER_HOME/bin/zkServer.sh" "start-foreground"

