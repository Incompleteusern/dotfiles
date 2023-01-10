#!/bin/bash

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# INSTALLATION

# Add colors to /etc/pacman.conf 
sed -i "s/#Color/Color" /etc/pacman.conf
# cat ILoveCandy >> /etc/pacman.con

# yay
pacman -S git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
rm -rf yay

# network manager and add local host to /etc/hosts - https://wiki.archlinux.org/title/Network_configuration#localhost_is_resolved_over_the_network
yay -S networkmanager
echo -e "127.0.0.1        localhost\n::1              localhost" >> /etc/hosts

# nano
yay -S nano nano-syntax-highlighting

# SYMLINKING

# .config
ln -s ${BASEDIR}/config ~/.config

# DESKTOP

# UTILITIES

# APPLICATIONS
yay -S firefox
