#!/bin/bash
conf_dir=$HOME/software/nginx/web/conf
if [ ! -d "$conf_dir" ]; then
  mkdir -p $conf_dir
fi
if [ ! -e "$conf_dir/nginx.conf" ]; then
  cp nginx.conf $conf_dir
fi
cert_dir=$HOME/software/nginx/web/cert
if [ ! -e "$cert_dir/nginx.crt" ]; then
  echo "copy nginx.crt to ${cert_dir}"
  exit 1
fi
if [ ! -e "$cert_dir/nginx.key" ]; then
  echo "copy nginx.key to ${cert_dir}"
  exit 1
fi
html_dir=$HOME/software/nginx/web/html
docker run -d --name pek-web -h pek-web -v $html_dir:/usr/share/nginx/web -v $conf_dir/nginx.conf:/etc/nginx/nginx.conf:ro -v $cert_dir/nginx.crt:/etc/nginx/nginx.crt -v $cert_dir/nginx.key:/etc/nginx/nginx.key -p 4431:4431 nginx:stable-alpine
