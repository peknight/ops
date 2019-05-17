#!/bin/bash
while getopts :u: opt
do
    case "$opt" in
        u) UUID=$OPTARG;;
        *) echo "Unknown option: $opt";;
    esac
done
conf_dir=$HOME/software/v2ray/client/etc
if [ ! -d "$conf_dir" ]; then
  mkdir -p $conf_dir
fi
if [ ! -e "$conf_dir/config.json" ]; then
  cp config.json $conf_dir/ 
  if [ -n "$UUID" ]; then
    sed -i "s/60ca58e9-003e-4c01-98de-c2223ae49153/$UUID/g" $conf_dir/config.json
  fi
fi
log_dir=$HOME/software/v2ray/client/log
if [ ! -d "$log_dir" ]; then
  mkdir -p $log_dir
fi
if [ ! -e "$log_dir/access.log" ]; then
  touch $log_dir/access.log
fi
if [ ! -e "$log_dir/error.log" ]; then
  touch $log_dir/error.log
fi
docker run -d --name pek-v2ray-client -h pek-v2ray-client -v $conf_dir/config.json:/etc/v2ray/config.json -v $log_dir:/var/log/v2ray -p 1080:1080 v2ray/official
