#!/bin/bash
conf_dir=$HOME/software/shadowsocks/server-libev/etc
if [ ! -d "$conf_dir" ]; then
  mkdir -p $conf_dir
fi
if [ ! -e "$conf_dir/config.json" ]; then
  cp config.json $conf_dir/ 
fi
docker run -d --name pek-ssserver-libev -h pek-ssserver-libev -v $conf_dir/config.json:/etc/shadowsocks-libev/config.json --net host --cap-add NET_ADMIN pek/shadowsocks-server-libev:3.2.5
