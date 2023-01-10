## Inspired by

- https://github.com/scotus-1/dotfiles
- https://github.com/flick0/dotfiles

TODO:
- Add dotfiles
- Add disk encryption
  - Do this in February when wifi-adapter is natively supported by udev
- Redoeverything
- Configs for desktop
  - Configure hyprland
  - Configure Waybar based off flick0
    - Language, Battery (CPU, Temperature when hover), Wifi/Network, Clock, Expand (Language, Emoji, Screenshot) on the right
    - Wayspaces on the left
    - MPR player in the middle: use flick0 then eventually integrate with spotify
  - Configure Dunst
  - Rofi-emoji, Rofi-wifi-menu + merge active prs, Make a rofi language gui since why not
- Gen Rec Step: Users and groups
- Screensharing, App Launchers, App Clients, Color Pickers
- Man
- zsh + ohmyzsh, 
- SSH/GPG for gh

Installation Notes
- Standard Installation
  - https://wiki.archlinux.org/title/Installation_guide
  - Right now, temporary android tether to set up and get driver rtw89 manually
- Linux install | `linux linux-firmware`
- Add user (after arch-chroot) 
  - `useradd -m $user; passwd $user; usermod -aG wheel,audio,video,optical,storage $user`
- Add wheel group to sudoers | `sudo`
  - `sed -i "s/#%wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL" /etc/sudoers`
- Processor Microcode | `intel_ucode`
- Text Editor | `nano nano-syntax-highlighting`

Desktop
- Compositor | `hyprland-git`
- Notification System | `dunst`
- Status Bars | `waybar-hyprland-git`

- Pipewire | `pipewire pipewire-jack wireplumber`
- Polkit | `polkit-kde-agent`
- Status Bars | `waybar-hyprland-git`
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
