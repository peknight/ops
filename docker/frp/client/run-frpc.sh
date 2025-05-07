#!/bin/bash
conf_dir=$HOME/software/frp/client/conf
if [ ! -d "$conf_dir" ]; then
  mkdir -p $conf_dir
fi
if [ ! -e "$conf_dir/frpc.ini" ]; then
  cp frpc.toml $conf_dir/
fi
docker run -d --name pek-frpc -h pek-frpc -v $conf_dir:/conf pek/frpc:0.62.1
