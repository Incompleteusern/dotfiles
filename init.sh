#!/bin/bash

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# INSTALLATION

# CONFIG

# Add colors to /etc/pacman.conf 
sed -i "s/#Color/Color" /etc/pacman.conf
# cat ILoveCandy >> /etc/pacman.conf

# COPY to .config
cp -a ${BASEDIR}/config/ ~/.config/

# DESKTOP

# hyprland
yay -S --noconfirm hyprland-git dunst waybar-hyprland-git swww xdg-utils

# pipewire
yay -S --noconfirm pipewire wireplumber pipewire-jack pipewire-pulse

# UTILITIES

# APPLICATIONS

# firefox - prefer pipewire-jack by earlier
yay -S --noconfirm firefox

# discord
yay -S --noconfirm discord_arch_electron
