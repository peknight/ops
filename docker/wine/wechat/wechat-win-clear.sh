#!/bin/bash
for winid in $(wmctrl -lGxp | sed -r '/pek-wechat\s*(ChatContactMenu)*$/!d;s/^(\S*).*$/\1/')
do
    xdotool windowunmap $winid
done
