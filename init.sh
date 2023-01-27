#!/bin/bash

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
USER = whoami

# INSTALLATION

# yay
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si 
cd .. 
rm -rf yay

# zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
gcl https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
gcl https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
gcl https://github.com/zsh-users/zsh-completions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions
rm .bash_history .bash_logout .bash_profile .bashrc

# pacman utils
yay -S pacgraph
systemctl enable paccache.timer

# networkmanager
echo "127.0.0.1        localhost" >> /etc/hosts
echo "::1              localhost" >> /etc/hosts


# add ~/scripts to path
echo "export PATH=\"${PATH}:/home/${USER}/scripts\"" >> ~/.zshrc

# Add colors to /etc/pacman.conf 
sed -i "s/#Color/Color" /etc/pacman.conf
sed -i "s/#ParallelDownloads/ParallelDownloads" /etc/pacman.conf
# cat ILoveCandy >> /etc/pacman.conf

# Copy to .config
cp -R ${BASEDIR}/.config/ ~/.config/
cp -R ${BASEDIR}/scripts/ ~/scripts/
cp -R ${BASEDIR}/.zshrc ~/.zshrc

# DESKTOP

# hyprland and friends
yay -S hyprland-git xdg-utils otf-font-awesome ttf-meslo-nerd-font-powerlevel10k

# bars
yay -S waybar-hyprland-git

# wallpaper
yay -S swww-git

# notifications
yay -S dunst libnotify

# app launcher thing
yay -S rofi-lbonn-wayland-git papirus-icon-theme-git sif-git

# terminal
yay -S alacritty-git

# desktop utilities
yay -S brightnessctl pamixer

# pipewire
yay -S pipewire wireplumber pipewire-jack pipewire-pulse

# UTILITIES

# fonts
yay -S ttf-ms-fonts noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra ttf-material-icons-git ttf-symbola

# command line
yay -S bat duf exa fzf fd httpie gping-git

# screenshots
yay -S grim slurp wl-clipboard jq

# power
yay -S tlp tlp-rdw
systemctl enable tlp.service 
systemctl enable NetworkManager-dispatcher.service
systemctl mask systemd-rfkill.service systemd-rfkill.socket

# SILLY
yay -S neofetch-git cbonsai donut.c cmatrix-git aalib

# APPLICATIONS

# firefox - prefer pipewire-jack by earlier
yay -S firefox prismlauncher steam visual-studio-code-bin

yay -S discord_arch_electron betterdiscordctl

betterdiscordctl install
