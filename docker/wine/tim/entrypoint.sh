#!/bin/bash
/opt/deepinwine/apps/Deepin-$APP/run.sh
sleep 300

while [ -n "$(pidof QQProtect.exe)" ]
do
    sleep 60
done
