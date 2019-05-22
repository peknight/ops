#!/bin/bash
target_dir=$HOME/software/softether/vpnserver
if [ ! -d "$target_dir" ]; then
  mkdir -p $target_dir
fi
if [ ! -e "$target_dir/vpn_server.config" ]; then
  cp vpn_server.config $target_dir/ 
fi
docker run -d --name pek-vpn -h pek-vpn -v $target_dir/vpn_server.config:/usr/local/softether/vpnserver/vpn_server.config -p 500:500/udp -p 1194:1194/udp -p 4500:4500/udp --cap-add NET_ADMIN pek/softethervpn:4.29-9680
