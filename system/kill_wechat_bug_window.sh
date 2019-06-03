#!/bin/bash
# 关闭deepwine-wechat的BUG窗口
xdotool windowunmap $(wmctrl -lGxp | sed -r '/wechat/!d;/WeChat/d;s/^(\S*).*$/\1/')
