FROM centos:7
MAINTAINER peknight <JKpeknight@gmail.com>

ENV VERSION v4.29-9680-rtm-2019.02.28
WORKDIR /usr/local/softether/vpnserver

RUN yum -y update \ 
    && yum -y install wget make gcc iptables \
    && wget "https://github.com/SoftEtherVPN/SoftEtherVPN_Stable/releases/download/v4.29-9680-rtm/softether-vpnserver-v4.29-9680-rtm-2019.02.28-linux-x64-64bit.tar.gz" -O /tmp/softether-vpnserver.tar.gz \
    && tar -xf /tmp/softether-vpnserver.tar.gz -C /usr/local/softether/ \
    && rm -f /tmp/softether-vpnserver.tar.gz \
    && make i_read_and_agree_the_license_agreement

EXPOSE 443/tcp 500/udp 992/tcp 1194/tcp 1194/udp 4500/udp 5555/tcp

ENTRYPOINT ["/usr/local/softether/vpnserver/vpnserver", "execsvc"]
