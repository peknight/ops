#!/bin/sh
target_dir=/root/software/acme.sh
if [ ! -d "$target_dir/out" ]; then
  mkdir -p $target_dir/out
fi
docker run --rm -it --name pek-acme-standalone -h pek-acme-standalone -v $target_dir/out:/acme.sh --net host neilpang/acme.sh --issue -d peknight.com -d *.peknight.com --standalone -k ec-256
