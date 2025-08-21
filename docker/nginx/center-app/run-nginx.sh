#!/bin/bash
conf_dir=$HOME/software/peknight/center-app/conf
if [ ! -d "$conf_dir" ]; then
  mkdir -p $conf_dir
fi
if [ ! -e "$conf_dir/nginx.conf" ]; then
  cp nginx.conf $conf_dir
fi
logs_dir=$HOME/software/peknight/center-app/logs
if [ ! -d "$logs_dir" ]; then
  mkdir -p $logs_dir
fi
if [ ! -e "$logs_dir/access.log" ]; then
  touch $logs_dir/access.log
fi
if [ ! -e "$logs_dir/error.log" ]; then
  touch $logs_dir/error.log
fi
cert_dir=$HOME/software/peknight/center-app/cert
if [ ! -e "$cert_dir/nginx.crt" ]; then
  echo "copy nginx.crt to ${cert_dir}"
  exit 1
fi
if [ ! -e "$cert_dir/nginx.key" ]; then
  echo "copy nginx.key to ${cert_dir}"
  exit 1
fi
docker run -d --name pek-center-web -h pek-center-web \
           -e TZ="Asia/Shanghai" \
           -v $conf_dir/nginx.conf:/etc/nginx/nginx.conf:ro \
           -v $logs_dir:/var/log/nginx \
           -v $cert_dir/nginx.crt:/etc/nginx/nginx.crt:ro \
           -v $cert_dir/nginx.key:/etc/nginx/nginx.key:ro \
           --net host \
           nginx:stable-alpine
