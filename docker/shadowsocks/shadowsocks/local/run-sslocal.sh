#!/bin/bash
conf_dir=$HOME/software/shadowsocks/local/etc
if [ ! -d "$conf_dir" ]; then
  mkdir -p $conf_dir
fi
if [ ! -e "$conf_dir/shadowsocks.json" ]; then
  cp shadowsocks.json $conf_dir/ 
fi
docker run -d --name pek-sslocal -h pek-sslocal -v $conf_dir/shadowsocks.json:/etc/shadowsocks.json -p 1080:1080 pek/shadowsocks-local
