FROM pek/deepin-wine:i386
MAINTAINER peknight <JKpeknight@gmail.com>

ENV APP=TIM \
    AUDIO_GID=995 \
    VIDEO_GID=986 \
    GID=612 \
    UID=612

ADD entrypoint.sh /
RUN apt-get update && \
    apt-get install -y --no-install-recommends deepin.com.qq.office dbus-x11 && \
    apt-get -y autoremove --purge && apt-get -y autoclean && apt-get -y clean && \
    find /var/lib/apt/lists -type f -delete && \
    find /var/cache -type f -delete && \
    find /var/log -type f -delete && \
    find /usr/share/doc -type f -delete && \
    find /usr/share/man -type f -delete && \
    groupadd -o -g $GID qq && \
    groupmod -o -g $AUDIO_GID audio && \
    groupmod -o -g $VIDEO_GID video && \
    useradd -c "qq" -g qq -G audio,video -m -d "/home/qq" -s /bin/bash -o -u $UID qq && \
    mkdir /TencentFiles && \
    chown -R qq:qq /TencentFiles && \
    ln -s "/TencentFiles" "/home/qq/Tencent Files" && \
    sed -i 's/TIM.exe" &/TIM.exe"/g' "/opt/deepinwine/tools/run.sh" && \
    chmod +x /entrypoint.sh

VOLUME ["/TencentFiles"]
USER qq

ENTRYPOINT ["/entrypoint.sh"]
