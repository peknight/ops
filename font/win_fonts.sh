mkdir /usr/share/fonts/windows
cp -r $HOME/software/microsoft/windows/font/* /usr/share/fonts/windows/
cd /usr/share/fonts/windows/
mkfontscale
mkfontdir
fc-cache
