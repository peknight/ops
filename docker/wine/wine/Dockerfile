FROM pek/deepin:panda-i386
MAINTAINER peknight <JKpeknight@gmail.com>

RUN apt-get update && \
    apt-get install -y --no-install-recommends locales && \
    echo 'zh_CN.UTF-8 UTF-8' > /etc/locale.gen && \
    locale-gen && \
    echo -e 'LANG="zh_CN.UTF-8"\nLANGUAGE="zh_CN:zh"\n' > /etc/default/locale && \
    source /etc/default/locale && \
    apt-get install -y --no-install-recommends fonts-wqy-microhei deepin-wine deepin-wine32 deepin-wine32-preloader deepin-wine-helper deepin-wine-uninstaller && \
    apt-get -y autoremove --purge && apt-get -y autoclean && apt-get -y clean && \
    find /var/lib/apt/lists -type f -delete && \
    find /var/cache -type f -delete && \
    find /var/log -type f -delete && \
    find /usr/share/doc -type f -delete && \
    find /usr/share/man -type f -delete
ENV LANGUAGE=zh_CN.UTF-8 \
    LC_ALL=zh_CN.UTF-8 \
    LANG=zh_CN.UTF-8 \
    TZ=UTC-8

ENTRYPOINT ["deepin-wine"]
