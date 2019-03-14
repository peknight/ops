#!/bin/bash

# 安装tilix
apt -y install tilix
# 软连接tilix配置文件
ln -s /etc/profile.d/vte-2.91.sh /etc/profile.d/vte.sh
# 配置tilix
echo 'if [ $TILIX_ID ] || [ $VTE_VERSION ]; then' >> $HOME/.bashrc
echo '        source /etc/profile.d/vte.sh' >> $HOME/.bashrc
echo 'fi' >> $HOME/.bashrc
