#!/bin/bash
conf_dir=$HOME/software/v2ray/server/etc
if [ ! -d "$conf_dir" ]; then
  mkdir -p $conf_dir
fi
if [ ! -e "$conf_dir/config.json" ]; then
  cp config.json $conf_dir/ 
  UUID=$(cat /proc/sys/kernel/random/uuid)
  sed -i "s/60ca58e9-003e-4c01-98de-c2223ae49153/$UUID/g" $conf_dir/config.json
fi

log_dir=$HOME/software/v2ray/server/log
if [ ! -d "$log_dir" ]; then
  mkdir -p $log_dir
fi
if [ ! -e "$log_dir/access.log" ]; then
  touch $log_dir/access.log
fi
if [ ! -e "$log_dir/error.log" ]; then
  touch $log_dir/error.log
fi
docker run -d --name pek-v2ray-server -h pek-v2ray-server -v $conf_dir/config.json:/etc/v2ray/config.json -v $log_dir:/var/log/v2ray --net host --cap-add NET_ADMIN v2ray/official
