#!/bin/bash
target_dir=$HOME/software/nginx/data/file
if [ ! -d "$target_dir" ]; then
  mkdir -p $target_dir
fi
conf_dir=$HOME/software/nginx/etc/file
if [ ! -d "$conf_dir" ]; then
  mkdir -p $conf_dir
fi

if [ ! -e "$conf_dir/nginx.conf" ]; then
  cp nginx.conf $conf_dir
fi
docker run -d --name pek-file -h pek-file -v $target_dir:/data/file -v $conf_dir/nginx.conf:/etc/nginx/nginx.conf:ro -p 8080:8080 nginx
