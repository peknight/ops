#!/bin/bash
docker run -d --restart always --name pek-nas-dns-config -h pek-nas-dns-config --net host --cap-add NET_ADMIN pek-nas-dns-config:0.1-SNAPSHOT
