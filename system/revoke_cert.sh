#!/bin/sh
target_dir=/root/software/acme.sh
if [ ! -d "$target_dir/out" ]; then
  mkdir -p $target_dir/out
fi
docker run --rm -it --name pek-acme-revoke -h pek-acme-revoke -v $target_dir/out:/acme.sh --net host neilpang/acme.sh --revoke -d peknight.com -d *.peknight.com -d *.server.peknight.com -d *.v6.server.peknight.com -d *.ctrl.peknight.com -d *.cdn.peknight.com -d *.v6.cdn.peknight.com --ecc
