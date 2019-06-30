FROM pek/deepin-wine:i386
MAINTAINER peknight <JKpeknight@gmail.com>

ENV APP=WeChat \
    AUDIO_GID=995 \
    VIDEO_GID=986 \
    GID=612 \
    UID=612

RUN apt-get update && \
    apt-get install -y --no-install-recommends deepin.com.wechat && \
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

ENTRYPOINT ["/opt/deepinwine/apps/Deepin-WeChat/run.sh"]
