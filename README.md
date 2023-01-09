
TODO:
- Add dotfiles
  - Add bash script
    - https://www.anishathalye.com/2014/08/03/managing-your-dotfiles/
- Redoeverything
- Configs for desktop
  - Replace rofi with wofi
  - Config hyprland 
- https://wiki.archlinux.org/title/Security#CPU
- https://wiki.archlinux.org/title/Systemd#Basic_systemctl_usage
- Hardware auto-recognition?
- Screensharing, App Launchers, App Clients, Color Pickers
Man, zsh + ohmyzsh, 
- SSH/GPG


Installation Notes
- Standard Installation
  - https://wiki.archlinux.org/title/Installation_guide
  - Right now, temporary android tether to set up and get driver
- Processor Microcode | `intel_ucode`
- Add wheel to sudoers file
- `sed -i "s/#%wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL" /etc/sudoers`
- Linux install | `linux linux-firmware`
- Add colors to /etc/pacman.conf
- `sed -i "s/#Color/Color" /etc/pacman.conf` 
- Network Manager | `networkmanager`
- Localhost resolution https://wiki.archlinux.org/title/Network_configuration#localhost_is_resolved_over_the_network
- `echo -e "127.0.0.1        localhost\n::1              localhost" >> /etc/hosts`
- Text Editor (nano) | `nano nano-syntax-highlighting`
- Aur Helper (yay) | ` git base-devel`
- `git clone https://aur.archlinux.org/yay.git; cd yay; makepkg -si; cd ..; rm -rf yay`

Desktop
- Compositor | `hyprland-git`
- Monitors?
- Notification System | `dunst`
- Configure?
- Pipewire | `pipewire pipewire-jack wireplumber`
- Polkit | `polkit-kde-agent`
- Status Bars | `waybar-hyprland-git`
  - Configure?
- Widgets | `eww-wayland`
- Configure?
- Wallpapers | `swww`
- Configure? AI gen might be fun
- App Launcher | `rofi-lbonn-wayland-git`
- Display Manager | `sddm`

- alacritty | `alacritty`


Utilities



Applications
- Firefox | `firefox`
- Discord | TODO decide which one to use
- Prism Launcher | `prismlauncher` TODO
