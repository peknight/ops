#!/bin/bash
conf_dir=$HOME/software/v2fly/server/conf
if [ ! -d "$conf_dir" ]; then
  mkdir -p $conf_dir
fi
if [ ! -e "$conf_dir/config.json" ]; then
  cp config.json $conf_dir/ 
  UUID=$(cat /proc/sys/kernel/random/uuid)
  sed -i "s/60ca58e9-003e-4c01-98de-c2223ae49153/$UUID/g" $conf_dir/config.json
fi
#cert_dir=$HOME/software/v2fly/server/cert
#if [ ! -e "$cert_dir/v2fly.crt" ]; then
#  echo "copy v2fly.crt to ${cert_dir}"
#  exit 1
#fi
#if [ ! -e "$cert_dir/v2fly.key" ]; then
#  echo "copy v2fly.key to ${cert_dir}"
#  exit 1
#fi
log_dir=$HOME/software/v2fly/server/log
if [ ! -d "$log_dir" ]; then
  mkdir -p $log_dir
fi
if [ ! -e "$log_dir/access.log" ]; then
  touch $log_dir/access.log
fi
if [ ! -e "$log_dir/error.log" ]; then
  touch $log_dir/error.log
fi
docker run -d --restart always --name pek-v2fly-server -h pek-v2fly-server \
           -e V2RAY_VMESS_AEAD_FORCED=false \
           -v $conf_dir/config.json:/etc/v2fly/config.json \
           -v $log_dir:/var/log/v2fly \
           --net host --cap-add NET_ADMIN \
           v2fly/v2fly-core:v5.30.0 \
           run -c /etc/v2fly/config.json
