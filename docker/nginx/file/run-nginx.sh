#!/bin/bash
data_dir=$HOME/software/nginx/file/data
if [ ! -d "$data_dir" ]; then
  mkdir -p $data_dir
fi
conf_dir=$HOME/software/nginx/file/conf
if [ ! -d "$conf_dir" ]; then
  mkdir -p $conf_dir
fi

if [ ! -e "$conf_dir/nginx.conf" ]; then
  cp nginx.conf $conf_dir
fi
docker run -d --name pek-file -h pek-file -v $data_dir:/data/file -v $conf_dir/nginx.conf:/etc/nginx/nginx.conf:ro -p 33101:33101 nginx:stable-alpine
