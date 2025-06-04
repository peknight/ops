FROM centos:7
MAINTAINER peknight <JKpeknight@gmail.com>

ENV VERSION v4.28-9669-beta-2018.09.11
WORKDIR /usr/local/softether/vpnserver
ADD softether-vpnserver-v4.28-9669-beta-2018.09.11-linux-x64-64bit.tar.gz /usr/local/softether

RUN yum -y update \ 
    && yum -y install make gcc iptables \
    && make i_read_and_agree_the_license_agreement

EXPOSE 443/tcp 500/udp 992/tcp 1194/tcp 1194/udp 4500/udp 5555/tcp

ENTRYPOINT ["/usr/local/softether/vpnserver/vpnserver", "execsvc"]
