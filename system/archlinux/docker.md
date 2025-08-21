# Docker

* [Docker](https://wiki.archlinux.org/index.php/Docker)

## 安装Docker与Docker Compose

```shell
pacman -Sy docker docker-compose
```

## 配置Docker的bash-completion

```shell
mkdir -p /etc/bash_completion.d/
curl -L https://raw.githubusercontent.com/docker/machine/v0.16.0/contrib/completion/bash/docker-machine.bash -o /etc/bash_completion.d/docker-machine
```

## 配置Docker IPv6

* 创建/etc/docker/daemon.json文件，内容如下

```json
{
  "ipv6": true,
  "fixed-cidr-v6": "fd00::/80"
}
```

* 配置下ip6tables，暂不知道原理

```shell
ip6tables -t nat -A POSTROUTING -s fd00::/80 ! -o docker0 -j MASQUERADE
ip6tables-save -f /etc/iptables/ip6tables.rules
```

## 配置自启动项

```shell
systemctl enable docker
systemctl enable iptables
systemctl enable ip6tables
```

## 用户添加到docker组

```shell
gpasswd -a pek docker
```
