#!/bin/bash

# 修改主机名 ubuntu修改/etc/hostname文件
host_name=pek-alibj-00
echo "$host_name" > /etc/hostname
hostname $host_name

# 修改host文件 追加localhost一行
#vim /etc/hosts
#127.0.0.1       localhost $host_name

# 安装更新
apt -y update

# 安装Docker
curl -sSL https://get.docker.com/ > docker.sh
sh docker.sh

# 安装必要软件
# apt -y curl netstat openssh-server vim wget
apt -y install emacs gawk git zsh
# 更新
apt -y update
apt -y full-upgrade
# 重启docker
systemctl restart docker

# 全局PATH变量加.
#echo "export PATH=.:$PATH" >> /etc/profile

# 设置默认编辑器，选4
#update-alternatives --config editor

# 添加用户组
groupadd -g 612 pek
groupadd shared
groupadd tauriel

# 添加用户
useradd -c "peknight" -g pek -G adm,cdrom,sudo,dip,plugdev,shared,docker -m -s /bin/bash -u 612 pek
echo 'pek   ALL=(ALL)  NOPASSWD:ALL' | sudo EDITOR='tee -a' visudo
# 设置密码
#passwd pek

# 添加用户
useradd -c "tauriel" -g tauriel -G adm,cdrom,sudo,dip,plugdev,shared,docker -m -s /bin/bash tauriel
echo 'tauriel ALL=(ALL) ALL' | sudo EDITOR='tee -a' visudo
# 设置密码
#passwd tauriel

# 切换用户
#su - pek

# 创建.ssh目录
home_dir=/home/pek
mkdir -p $home_dir/.ssh

echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCp1p1wnGV1T3rUOj+PbuL4LQx+n+GhZoHllau7pPLk+edJJmPlN02/Yhk+sWD/KMSKJnt5/5N+Itbfaa7Gl1swK07Ap0xtAF6AC5TqPkLIpQgm6zQxKRfthCIICgJpvqHejwS8NIX9GzwWzBsCmb0LnlTQgCoCIzDXeQ5iYAc82CPec0LogWcowR5cTe5BnnZxLcO56g1hs7M2UTW8ApNL96hNvxqNDkvmCmBJcSMX9gd0njCJriCkp5dCs+e7HK4f2U4GiRd8i9l5ZQ14XfxZMvPzVA9e9WkFCgkZXsuJLXUOjUA+DTn7YNnqaOyDE8mHbcqF5owR8mngs30iRAo7 peknight@peknight-pc" > $home_dir/.ssh/authorized_keys
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDQDyOKDl1HDR3JXuz6EWQwmhMUCd9P2aJWY3ECO94CywkaiB+GNBzUY9i1WXbXp1PbnD0lCG3bMF61Un8R8dt5KQd8T7qBwVCkKk6XqdIzYOTAzXYancBnq5PI61xNZgWELXUK9LopwxqSxgTjoZ4i1LnIxXmgSuh/Gvox2aDeUFIusG1zBeW8maH4A2kadZycLz7HTodMiviDTexRzG3TnSdG9EmzC43kevq4Hjd01iGpjbbFx6zUV6QSocHhHNM4OrbR/0PiWRoAykzL70MVT3LlkCQ335zNkgN2BSWtLuJcww5ks9k/kGnlXYo5KeX/Dwzc7K0x6Lus8hF2oGn1 peknight@iphone7" >> $home_dir/.ssh/authorized_keys
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC5BIk3lzsuVyMoMcLAk2WlaFgFHu+Fb4M2wgObpf0Fllo8HVTjUeX0tJYvyEIz3yHNfMuGy91Hxa4YOcNOtMCpliJBgkb0hmRuxaHlo4ZeAlVCmm12MPc7f3VsBZ3ABDPnBZdO+gQBGkQORz5Tc4OkVbi6qEfgb9bPADAmrzTpm+PBp4bV0+6ZFfx5oCurG6v37jlR83HYWJ7jGM+B16Hi5rrAvXx+wnaXimi2cHGlYiTk9vs2MoEgfvIpAgTRPuEZpEumG2Lcbr3pivbVI7aysadCm4fe/grG7J/grjaga+eQi+CmQJXRe9DjWB5Hx7XHjqL6MbWagF5sOImt1JZR peknight@ipadpro2" >> $home_dir/.ssh/authorized_keys
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDU9ut9YAMxfGgQ/eRoDpx5hjbA8G35/GEwcas0NHILEdSFe6TddSYqhKbAiW8OEfwfjGBaUI2Zw+XQJMJks+XipOqWIzxLWkUl3vD+VP5hHciofEvbrt4hPDbL5oWfQpixolL2D+38nYOoJh+wABcdQb+BRq0aWIz6zea3DFKHmYqZHiZe9ve9XT17r/muOOJI5pdzZeTriRBsH2coslJAvuSJbR5gfm7tEfUvNWL4yX9bIat8iL6pKWlrE8cJKQ+I6wqqndhYZCC02aTvEKV7alY+YJ5PtKAhEN+Z+L7RuorCVaxCo7nIO9FSgq508L25rV3EU8CQulWdIU2NJZS9 pek@pek-control" >> $home_dir/.ssh/authorized_keys
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCljOHJkK2wbPilXViaSnP6HpJjrbmnuaVv81GuX03IHOiFUcWpraCcqLvMNeGhAnA+MNMxKhl2QiuVAWk3tD/Duke1fcaWs5qSeM1w632Z5jPKXhwoTVzmPALry3l24nHBPhUB05iI52ZsSLzSTF1vyOTtIDhxq7jlJPKszU3Mt2xPlAzFEBuKqYHa8XcdZ1F7zb5AK4utdPc8iSA7fBE5jhb0AHwcBb1hcq/XY1tsuJgYzLj2tUnkxaBefimd1GOMudhLZyhI8sk9YXYjcdx+uwRN9O/G1MdlbGBvXS313MeCFHnooiUSEkv5Y7nKGsVwaXXt8XEKoj70ZYb2BGch pek@pek-sgp1-00" >> $home_dir/.ssh/authorized_keys
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDNGbTc/zwFbeJJ+2HrxUsGkhKzckDbqWART8+wd9BNFOlZh/pVAW+LcJXll+ss0/Vi6ebnOxbrYiiQk8xywdw2aAZTeTD+fH6HpC2k9WhmdngdS+ib3UfO7SH7GBdwyCfjGoKnRukzT4bsNZmcEkbWYxchv6rbNPeeA6CfkhqPMMv/oDtQfa12p+gUwmtMTBt12gGmmb5buvWiikVdrHiEeR0ETuTXEf8kCU0RLlq/I71f1nq9E6HSRMolsOiKGLWoj/6bVYAk7H5XOMWfK4gx/UThEFslDZW3wnWH3H7aDmmrJCLYLvgh00znlnWRaZ/b7+YhE7c9z5Ew/VTh3i8D pek@pek-nyc3-00" >> $home_dir/.ssh/authorized_keys
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC8NHS+HcGAyA8+b+/sXQq26REnTXwjvOrEv3V35kcra46PtlfC8JKYSyqKpXCw5r7nIJ3XrkWTus6Zu2BLjptcGeLZqgfkdkiD3jCIN0KFFrNbwh/zX2Sh4QOhLxxM+yKiVLINaOKaXM1PgAsdorzeCgXiSKLe+QruniP9tn0t36Y7H4B8/dnzNoYpFTPfN3uVUl90qrPxESiJj8vhF/ANJXHLraAdf86SOb7xEsZQYIwp0BfOU5omZlsohWiVmIxmfM8APj/1cpk7IyJNZdvHejPC/Fwhfm+cOce84zEcuW0EmMqB3nG5ajJedXKuOorQ9spy7ZrMBYlhDcU3cpb1 pek@pek-sfo2-00" >> $home_dir/.ssh/authorized_keys
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDgHDJYVcFKcpUOoGZB28cFskfwALgcj1OP503g1LRZDJrkhowj0X7rGJ7kJM2gUmnqeG/enDQCW+k/Gp3K5Cd7qBpMF2OqAbdmDOGKxuD3wl/jRaBZzRnwsfqythMJXXXXTtOMpww0PVWYUNS5WdikOAdIZDLqMYjzP2NFmKNtPpJtFFPR9ORIzp4lc6zQbJOu+siZDh2YJ9Fah6mtBFZiJ34WYiHYjU/pszM1DRmgUx0nnZyHQakrqeupuc7pKm3qr8GEtzPr8y4M89HImaUxG7Urdgo1kyxnl8ybln/1+ushjIuo9a5lgydhJlEvERYenGyEstM3Cj9Ul+i2q3V7 rengang@joinquant.com" >> $home_dir/.ssh/authorized_keys

# 设置密钥对$HOME/.ssh/id_rsa $HOME/.ssh/id_rsa.pub

# 设置.ssh目录权限
chmod 700 $home_dir/.ssh
chmod 400 $home_dir/.ssh/*

# 设置git
git config --global user.name "peknight"
git config --global user.email "JKpeknight@gmail.com"
git clone git@github.com:peknight/ops.git

# 软连接.vimrc
ln -s $home_dir/ops/vim/vimrc $home_dir/.vimrc

# 设置环境变量
echo "export PATH=\$HOME/bin/ssh:\$PATH" >> $home_dir/.bashrc
source $home_dir/.bashrc

#su - tauriel
home_dir=/home/tauriel
mkdir -p $home_dir/.ssh
cd $home_dir/.ssh
#ssh-keygen -C "tauriel@pek-control"
# 设置.ssh目录权限
chmod 700 $home_dir/.ssh
chmod 400 $home_dir/.ssh/*

# 修改sshd_config文件 修改ssh端口号 注意开通8612端口号的防火墙
#vim /etc/ssh/sshd_config
#Port 8612
#PermitRootLogin no
#PasswordAuthentication no
#service sshd restart

