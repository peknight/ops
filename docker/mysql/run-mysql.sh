#!/bin/bash
target_dir=$HOME/software/mysql/pek/data
conf_dir=$HOME/software/mysql/pek/etc/conf.d
if [ ! -d "$target_dir" ]; then
  mkdir -p $target_dir
fi
if [ ! -d "$conf_dir" ]; then
  mkdir -p $conf_dir
fi
cp my.cnf $conf_dir/
docker run -d --name pek-mysql -h pek-mysql -e MYSQL_ROOT_PASSWORD=*** -e MYSQL_USER=pek -e MYSQL_PASSWORD=*** -v $target_dir:/var/lib/mysql -v $conf_dir:/etc/mysql/conf.d -p 3306:3306 mysql
