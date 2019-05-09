#!/bin/bash
conf_dir=$HOME/software/transmission/etc/downloads
if [ ! -d "$conf_dir" ]; then
  mkdir -p $conf_dir
fi
if [ ! -e "$conf_dir/settings.json" ]; then
  cp settings.json $conf_dir/
fi
data_dir=$HOME/software/transmission/data/downloads
if [ ! -d "$data_dir" ]; then
  mkdir -p $data_dir
fi
watch_dir=$HOME/software/transmission/watch/downloads
if [ ! -d "$watch_dir" ]; then
  mkdir -p $watch_dir
fi
docker run -d --name pek-transmission -h pek-transmission -e PUID=$(id -u) -e PGID=$(id -g) -e TZ=Asia/Beijing -e TRANSMISSION_WEB_HOME=/combustion-release/ -p 9091:9091 -p 51413:51413 -p 51413:51413/udp -v $conf_dir:/config -v $data_dir:/downloads -v $watch_dir:/watch linuxserver/transmission
