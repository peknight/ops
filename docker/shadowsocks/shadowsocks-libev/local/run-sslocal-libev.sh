#!/bin/bash
conf_dir=$HOME/software/shadowsocks/local-libev/etc
if [ ! -d "$conf_dir" ]; then
  mkdir -p $conf_dir
fi
if [ ! -e "$conf_dir/config.json" ]; then
  cp config.json $conf_dir/ 
fi
docker run -d --name pek-sslocal-libev -h pek-sslocal-libev -v $conf_dir/config.json:/etc/shadowsocks-libev/config.json -p 1080:1080  pek/shadowsocks-local-libev:3.2.5
