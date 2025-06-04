#!/bin/bash
target_dir=$HOME/software/redis/pek/data
conf_dir=$HOME/software/redis/pek/etc
if [ ! -d "$target_dir" ]; then
  mkdir -p $target_dir
fi
if [ ! -d "$conf_dir" ]; then
  mkdir -p $conf_dir
fi
cp redis.conf $conf_dir/
docker run -d --name pek-redis -h pek-redis -v $target_dir:/data -v $conf_dir/redis.conf:/usr/local/etc/redis/redis.conf -p 6379:6379 redis redis-server /usr/local/etc/redis/redis.conf
