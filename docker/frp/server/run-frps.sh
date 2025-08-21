#!/bin/bash
conf_dir=$HOME/software/frp/server/conf
if [ ! -d "$conf_dir" ]; then
  mkdir -p $conf_dir
fi
if [ ! -e "$conf_dir/frps.ini" ]; then
  cp frps.toml $conf_dir/
fi
docker run -d --restart always --name pek-frps -h pek-frps -v $conf_dir:/conf -p 7000:7000 -p 31001-31100:31001-31100 pek/frps:0.64.0
