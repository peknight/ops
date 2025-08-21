#!/bin/bash
conf_dir=$HOME/software/privoxy/etc
if [ ! -d "$conf_dir" ]; then
  mkdir -p $conf_dir
fi
if [ ! -e "$conf_dir/config" ]; then
  cp config $conf_dir/ 
fi
docker run -d --name pek-privoxy -h pek-privoxy -v $conf_dir/config:/etc/privoxy/config -p 8118:8118 pek/privoxy
