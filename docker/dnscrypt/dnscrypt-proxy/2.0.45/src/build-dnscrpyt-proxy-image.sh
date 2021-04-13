#!/bin/bash
wget "https://github.com/DNSCrypt/dnscrypt-proxy/releases/download/2.0.45/dnscrypt-proxy-linux_x86_64-2.0.45.tar.gz"
docker build -t pek/dnscrypt-proxy:2.0.45 .
