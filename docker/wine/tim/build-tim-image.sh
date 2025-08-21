#!/bin/bash
audio_gid=$(sed -rn 's/^audio:x:([0-9]*).*$/\1/p' /etc/group)
video_gid=$(sed -rn 's/^video:x:([0-9]*).*$/\1/p' /etc/group)
gid=$(id -g)
uid=$(id -u)
sed -ri "s/(AUDIO_GID=)[0-9]*/\1${audio_gid}/;s/(VIDEO_GID=)[0-9]*/\1${video_gid}/;s/( GID=)[0-9]*/\1${gid}/;s/( UID=)[0-9]*/\1${uid}/" Dockerfile
docker build -t pek/tim:deepin-wine .
