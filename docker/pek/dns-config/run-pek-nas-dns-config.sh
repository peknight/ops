#!/bin/bash
docker run -d --restart always --name pek-nas-dns-config -h pek-nas-dns-config -v /share/CACHEDEV1_DATA/pek/software/pek/dns-config/conf/pek-nas.conf:/opt/docker/conf/pek-nas.conf -v /share/CACHEDEV1_DATA/pek/software/pek/dns-config/log:/opt/docker/log --net host --cap-add NET_ADMIN pek/dns-config:0.1-SNAPSHOT
