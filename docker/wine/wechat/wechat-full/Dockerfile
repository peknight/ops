FROM scratch
MAINTAINER peknight <JKpeknight@gmail.com>

ADD rootfs.tar.xz /

ENV TERM=xterm \
    DEBIAN_FRONTEND=noninteractive \
    LANGUAGE=zh_CN.UTF-8 \
    LC_ALL=zh_CN.UTF-8 \
    LANG=zh_CN.UTF-8 \
    TZ=UTC-8 \
    APP=WeChat \
    AUDIO_GID=29 \
    VIDEO_GID=44 \
    GID=1000 \
    UID=1000

RUN rm /bin/sh && \
    ln -s /bin/bash /bin/sh && \
	sed -i "s/mesg n/tty -s \&\& mesg n/" /root/.profile && \
    echo 'deb https://mirrors.aliyun.com/deepin panda main non-free contrib' > /etc/apt/sources.list && \
    apt-get update && \
    apt --fix-broken -y install && \
    apt-get install -y --no-install-recommends locales && \
    echo 'zh_CN.UTF-8 UTF-8' > /etc/locale.gen && \
    locale-gen && \
    echo -e 'LANG="zh_CN.UTF-8"\nLANGUAGE="zh_CN:zh"\n' > /etc/default/locale && \
    source /etc/default/locale && \
    apt-get install -y --no-install-recommends fonts-wqy-microhei deepin-wine deepin-wine32 deepin-wine32-preloader deepin-wine-helper deepin-wine-uninstaller deepin.com.wechat && \ 
    apt-get -y autoremove --purge && apt-get -y autoclean && apt-get -y clean && \
    find /var/lib/apt/lists -type f -delete && \
    find /var/cache -type f -delete && \
    find /var/log -type f -delete && \
    find /usr/share/doc -type f -delete && \
    find /usr/share/man -type f -delete && \
    groupadd -o -g $GID wechat && \
    groupmod -o -g $AUDIO_GID audio && \
    groupmod -o -g $VIDEO_GID video && \
    useradd -c "wechat" -g wechat -G audio,video -m -d "/home/wechat" -s /bin/bash -o -u $UID wechat && \
    mkdir /WeChatFiles && \
    chown -R wechat:wechat /WeChatFiles && \
    ln -s "/WeChatFiles" "/home/wechat/WeChat Files" && \
    sed -i 's/WeChat.exe" &/WeChat.exe"/g' "/opt/deepinwine/tools/run.sh"

VOLUME ["/WeChatFiles"]
USER wechat
WORKDIR /WeChatFiles

ENTRYPOINT ["/opt/deepinwine/apps/Deepin-WeChat/run.sh"]
