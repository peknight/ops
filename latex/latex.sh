cd $HOME/software/aur/
git clone https://aur.archlinux.org/perl-term-shellui.git
cd perl-term-shellui
makepkg -si
cd ../
git clone https://aur.archlinux.org/texlive-localmanager-git.git
cd texlive-localmanager-git
makepkg -si
cd ../

