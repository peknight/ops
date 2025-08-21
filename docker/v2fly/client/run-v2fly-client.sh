#!/bin/bash
while getopts :u: opt
do
    case "$opt" in
        u) UUID=$OPTARG;;
        *) echo "Unknown option: $opt";;
    esac
done
conf_dir=$HOME/software/v2fly/client/conf
if [ ! -d "$conf_dir" ]; then
  mkdir -p $conf_dir
fi
if [ ! -e "$conf_dir/config.json" ]; then
  cp config.json $conf_dir/ 
  if [ -n "$UUID" ]; then
    sed -i "s/60ca58e9-003e-4c01-98de-c2223ae49153/$UUID/g" $conf_dir/config.json
  fi
fi
log_dir=$HOME/software/v2fly/client/log
if [ ! -d "$log_dir" ]; then
  mkdir -p $log_dir
fi
if [ ! -e "$log_dir/access.log" ]; then
  touch $log_dir/access.log
fi
if [ ! -e "$log_dir/error.log" ]; then
  touch $log_dir/error.log
fi
docker run -d --restart always --name pek-v2fly-client -h pek-v2fly-client -v $conf_dir/config.json:/etc/v2fly/config.json -v $log_dir:/var/log/v2fly -p 1080:1080 -p 8118:8118 v2fly/v2fly-core:v5.30.0 run -c /etc/v2fly/config.json

