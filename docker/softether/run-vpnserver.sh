#!/bin/bash
target_dir=$HOME/software/softether/vpnserver
if [ ! -d "$target_dir" ]; then
  mkdir -p $target_dir
fi
cp vpn_server.config $target_dir/ 
docker run -d --name pek-vpn -h pek-vpn -v $target_dir/vpn_server.config:/usr/local/softether/vpnserver/vpn_server.config --net host --cap-add NET_ADMIN pek/softethervpn:4.28-9669
