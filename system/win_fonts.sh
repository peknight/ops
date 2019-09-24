mkdir /mnt/win10
mount /dev/sda7 /mnt/win10
mkdir /usr/share/fonts/windows
cp -r /mnt/win10/Windows/Fonts/* /usr/share/fonts/windows/
rm /usr/share/fonts/windows/*.fon
chmod 644 /usr/share/fonts/windows/*
cd /usr/share/fonts/windows/
mkfontscale
mkfontdir
fc-cache

