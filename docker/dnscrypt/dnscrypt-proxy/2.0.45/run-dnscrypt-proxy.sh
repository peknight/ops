#!/bin/bash
conf_dir=$HOME/software/dnscrypt/dnscrypt-proxy/conf
log_dir=$HOME/software/dnscrypt/dnscrypt-proxy/log
if [ ! -d "$conf_dir" ]; then
  mkdir -p $conf_dir
fi
if [ ! -e "$conf_dir/dnscrypt-proxy.toml" ]; then
  cp dnscrypt-proxy.toml $conf_dir/
fi
if [ ! -d "$log_dir" ]; then
  mkdir -p $log_dir
fi
if [ ! -e "$log_dir/query.log" ]; then
  touch $log_dir/query.log
fi

docker run -d --restart always \
           --name pek-dnscrypt-proxy \
           -h pek-dnscrypt-proxy \
           -v $conf_dir/dnscrypt-proxy.toml:/usr/local/dnscrypt/dnscrypt-proxy/linux-x86_64/dnscrypt-proxy.toml \
           -v $log_dir/query.log:/usr/local/dnscrypt/dnscrypt-proxy/linux-x86_64/query.log \
           --dns 127.0.0.1 \
           -p 53:53/udp \
           -p 53:53/tcp  \
           pek/dnscrypt-proxy:2.0.45
