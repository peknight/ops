# 系统更新

apt update
apt upgrade

# 安装软件
apt install git zsh docker docker-compose

# 添加用户
groupadd -g 1000 pek
useradd -c "pek" -g pek -m -s /bin/zsh -u 1000 pek
echo 'pek   ALL=(ALL)  NOPASSWD:ALL' | EDITOR='tee -a' visudo
passwd pek
gpasswd -a pek docker

# 切换用户

su - pek

# 配置pek用户密钥

# 配置git
git config --global user.name "peknight"
git config --global user.email "JKpeknight@gmail.com"
git config --global pull.rebase false

# 配置sshd

vim /etc/ssh/sshd_config

# Port 8612
# PermitRootLogin no
# PasswordAuthentication no

# 自启动

systemctl enable docker

