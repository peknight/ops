#!/bin/bash
data_dir=$HOME/software/aria2/pt/data
if [ ! -d "$data_dir" ]; then
  mkdir -p $data_dir
fi
conf_dir=$HOME/software/aria2/pt/conf
if [ ! -d "$conf_dir" ]; then
  mkdir -p $conf_dir
fi

if [ ! -e "$conf_dir/aria2.conf" ]; then
  cp aria2.conf $conf_dir/
fi
if [ ! -e "$conf_dir/aria2.session" ]; then
  touch  $conf_dir/aria2.session
fi
tracker=$(curl -sSL 'https://raw.githubusercontent.com/ngosang/trackerslist/master/trackers_best.txt' | sed '/^\s*$/d' | tee tracker | tr '\n' ',' | sed 's/,$//')
sed -i "s!^\(bt-tracker=\).*!\1${tracker}!;s/pek/$(id -nu)/g" $conf_dir/aria2.conf
docker run -d --name pek-aria2-pt -h pek-aria2-pt -v $conf_dir:/home/$(id -nu)/.aria2 -v $data_dir:/data --net host --cap-add NET_ADMIN pek/webui-aria2-pt
