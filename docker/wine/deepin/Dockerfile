FROM scratch
MAINTAINER peknight <JKpeknight@gmail.com>

ADD rootfs.tar.xz /

ENV TERM=xterm \
    DEBIAN_FRONTEND=noninteractive

RUN rm /bin/sh && \
    ln -s /bin/bash /bin/sh && \
    sed -i "s/mesg n/tty -s \&\& mesg n/" /root/.profile && \
    apt-get update && \
    apt --fix-broken -y install && \
    apt-get -y autoremove --purge && apt-get -y autoclean && apt-get -y clean && \
    find /var/lib/apt/lists -type f -delete && \
    find /var/cache -type f -delete && \
    find /var/log -type f -delete && \
    find /usr/share/doc -type f -delete && \
    find /usr/share/man -type f -delete

CMD ["bash"]

