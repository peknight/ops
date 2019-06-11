#!/bin/bash
conf_dir=$HOME/software/frp/server/conf
if [ ! -d "$conf_dir" ]; then
  mkdir -p $conf_dir
fi
if [ ! -e "$conf_dir/frps.ini" ]; then
  cp frps.ini $conf_dir/
fi
docker run -d --name pek-frps -h pek-frps -v $conf_dir:/conf pek/frps:0.27.0
