#!/bin/bash

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Add wheel to sudoers
sed -i "s/#%wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL" /etc/sudoers

# Add colors to /etc/pacman.conf
sed -i "s/#Color/Color" /etc/pacman.conf

# yay
pacman -S git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
rm -rf yay

# network manager and add local host to /etc/hosts
yay -S networkmanager
echo -e "127.0.0.1        localhost\n::1              localhost" >> /etc/hosts

# nano
yay -S nano nano-syntax-highlighting

# vim
ln -s ${BASEDIR}/config ~/.config
