firewall.sh --zone=public --add-rich-rule='rule family="ipv6" destination not address="fd00::1/80" source address="fd00::/80" masquerade'
/etc/init.d/container-station.sh restart
