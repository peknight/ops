#!/bin/bash
target_dir=$HOME/software/aria2/data/downloads
if [ ! -d "$target_dir" ]; then
  mkdir -p $target_dir
fi
conf_dir=$HOME/software/aria2/etc/downloads
if [ ! -d "$conf_dir" ]; then
  mkdir -p $conf_dir
fi

if [ ! -e "$conf_dir/aria2.conf" ]; then
  cp aria2.conf $conf_dir/
fi
docker run -d --name pek-aria2 -h pek-aria2 -v $conf_dir/aria2.conf:/home/dummy/.aria2/aria2.conf -v $target_dir:/data -p 6800:6800 -p 9100:8080 pek/webui-aria2
