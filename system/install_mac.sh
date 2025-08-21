# 安装oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# 配置配置oh-my-zsh theme
ln -s $HOME/ops/zsh/themes/pek-robbyrussell.zsh-theme $HOME/.oh-my-zsh/custom/themes/pek-robbyrussell.zsh-theme
# 配置vimrc
ln -s $HOME/ops/vim/vimrc $HOME/.vimrc
# 安装rime东风破
cd $HOME/software
curl -fsSL https://git.io/rime-install | bash
# 安装rime wubi86
bash rime-install wubi pinyin-simp
# 配置rime
ln -s $HOME/ops/rime/default.custom.yaml $HOME/Library/Rime/default.custom.yaml
# 安装homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
# 软连接.ssh/config
ln -s $HOME/ops/system/ssh_config $HOME/.ssh/config
