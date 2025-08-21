#!/bin/bash
target_dir=$HOME/software/aria2/downloads/data
if [ ! -d "$target_dir" ]; then
  mkdir -p $target_dir
fi
conf_dir=$HOME/software/aria2/downloads/etc
if [ ! -d "$conf_dir" ]; then
  mkdir -p $conf_dir
fi

if [ ! -e "$conf_dir/aria2.conf" ]; then
  cp aria2.conf $conf_dir/
fi
if [ ! -e "$conf_dir/aria2.session" ]; then
  touch $conf_dir/aria2.session
fi
tracker=$(curl -sSL 'https://raw.githubusercontent.com/ngosang/trackerslist/master/trackers_best.txt' | sed '/^\s*$/d' | tee tracker | tr '\n' ',' | sed 's/,$//')
sed -i "s!^\(bt-tracker=\).*!\1${tracker}!;s/pek/$(id -nu)/g" $conf_dir/aria2.conf
docker run -d --name pek-aria2 -h pek-aria2 -v $conf_dir:/home/$(id -nu)/.aria2 -v $target_dir:/data -p 6800:6800 -p 9100:9100 -p 35500-35599:35500-35599 -p 35500-35599:35500-35599/udp pek/webui-aria2
