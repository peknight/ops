#!/bin/bash
wget "https://github.com/SoftEtherVPN/SoftEtherVPN_Stable/releases/download/v4.28-9669-beta/softether-vpnserver-v4.28-9669-beta-2018.09.11-linux-x64-64bit.tar.gz"
docker build -t pek/softethervpn:4.28-9669 .
