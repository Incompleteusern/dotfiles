#!/bin/bash

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# INSTALLATION

# CONFIG

# Add colors to /etc/pacman.conf 
sed -i "s/#Color/Color" /etc/pacman.conf
# cat ILoveCandy >> /etc/pacman.conf

# SYMLINKS

# hypr
ln -s ${BASEDIR}/config/hypr ~/.config/hypr

# DESKTOP

# hyprland
yay -S --noconfirm hyprland-git dunst waybar-hyprland-git

# pipewire
yay -S --noconfirm pipewire pipewire-jack wireplumber

# UTILITIES

# APPLICATIONS

# firefox - prefer pipewire-jack by earlier
yay -S --noconfirm firefox

# discord
yay -S --noconfirm discord_arch_electron
