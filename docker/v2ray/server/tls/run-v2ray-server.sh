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
cert_dir=$HOME/software/v2ray/server/cert
if [ ! -e "$cert_dir/v2ray.crt" ]; then
  echo "copy v2ray.crt to ${cert_dir}"
  exit 1
fi
if [ ! -e "$cert_dir/v2ray.key" ]; then
  echo "copy v2ray.key to ${cert_dir}"
  exit 1
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
docker run -d --name pek-v2ray-server -h pek-v2ray-server -v $conf_dir/config.json:/etc/v2ray/config.json -v $cert_dir/v2ray.crt:/etc/v2ray/v2ray.crt -v $cert_dir/v2ray.key:/etc/v2ray/v2ray.key -v $log_dir:/var/log/v2ray --net host --cap-add NET_ADMIN v2ray/official
