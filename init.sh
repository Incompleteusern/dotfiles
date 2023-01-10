#!/bin/bash

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# INSTALLATION

# yay
pacman -S git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
rm -rf yay

# CONFIG

# Add colors to /etc/pacman.conf 
sed -i "s/#Color/Color" /etc/pacman.conf
# cat ILoveCandy >> /etc/pacman.conf

# .config
ln -s ${BASEDIR}/config ~/.config

# DESKTOP

# UTILITIES

# APPLICATIONS
yay -S --noconfirm firefox

