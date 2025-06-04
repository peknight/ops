#!/bin/bash
conf_dir=$HOME/software/shadowsocks/server/etc
if [ ! -d "$conf_dir" ]; then
  mkdir -p $conf_dir
fi
if [ ! -e "$conf_dir/shadowsocks.json" ]; then
  cp shadowsocks.json $conf_dir/ 
fi
docker run -d --name pek-ssserver -h pek-ssserver -v $conf_dir/shadowsocks.json:/etc/shadowsocks.json --net host --cap-add NET_ADMIN pek/shadowsocks-server
