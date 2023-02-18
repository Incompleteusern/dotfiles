## Thanks to

- https://github.com/scotus-1/dotfiles for format and what to use xd
- https://github.com/flick0/dotfiles for various configs
- https://github.com/Saimoomedits/eww-widgets for the top bar, modified for catppuccin theming, hyprland and spotify 
- https://github.com/catppuccin for the pastel theming over basically everything I can touch
  - For rofi, deathmonde is used
- https://wiki.archlinux.org/title/User:Bai-Chiang/Installation_notes and https://gist.github.com/orhun/02102b3af3acfdaf9a5a2164bea7c3d6 and https://gist.github.com/michaelb081988/0e3f1bbd3bb04fb34c0726e28da2a934 for extended installation notes over encryption and so forth
- https://github.com/MarianArlt/sddm-sugar-dark/ for sddm theme, modified for catppuccin theming 

## INFO

These dotfiles come with three terrible scripts as of last updated:
- `local.sh` which syncs local files into this github repo
- `sync.sh` which syncs bundled github repos into local files, note that this contains repos I have forked 
- `init.sh` which installs the github repo into an arch install, should be run as root
- `initpackage.sh` which installs packages used

I don't know how well `init.sh` works right now, run anything here at your own risk :)

## TODO

TODO:
- https://wiki.archlinux.org/title/Bash/Prompt_customization
- Learn tmux
- Change mouse or something idk
- Customize oh-my-zsh more
- Configs for desktop
  - Wallpaper script time!!!!
  - EWW
    - Add customization if mute
    - CPU Info
- Screensharing, App Launchers, App Clients, Color Pickers
    - aka Configure Rest of Desktop
- Customize firefox + fork mozilla? 
- Go through general preference :SOB:
- Add disk encryption
  - https://wiki.archlinux.org/title/Dm-crypt/Device_encryption with sector-size
  - Do this in February when wifi-adapter is natively supported by udev
- Swap hibernation encryption support based on https://gist.github.com/orhun/02102b3af3acfdaf9a5a2164bea7c3d6#known-issues
- TODO renable secure boot support
- AI gen might be fun for wall paper

# Installation

## Manual
### Pre-Boot
- Standard installation

# THE BELOW IS UNTESTED SINCE I AM LAZY RUN AT YOUR OWN (VERY BIG) RISK

- Disable Secure Boot/Check it is disabled
  - `# bootctl status | grep "Secure Boot"`
- Right now, temporary android tether to set up and get driver rtw89 manually
- Three partitions and encryption
  - Make root, user, and swap partitions using `cblsk` and part labels `cryptroot`, `cryptuser`, and `cryptswap` (TODO make using fblsk in the future LOL)
  - https://wiki.archlinux.org/title/Dm-crypt/Device_encryption
  ```
     # cryptsetup benchmark
     # cryptsetup --type luks2 --verify-passphrase --sector-size 4096 --verbose luksFormat /dev/disk/by-partlabel/cryptroot
     # cryptsetup --type luks2 --verify-passphrase --sector-size 4096 --verbose luksFormat /dev/disk/by-partlabel/cryptuser
     # cryptsetup --type luks2 --verify-passphrase --sector-size 4096 --verbose luksFormat /dev/disk/by-partlabel/cryptswap
     
     # cryptsetup luksHeaderBackup /dev/disk/by-partlabel/cryptroot --header-backup-file /mnt/backupcrypt/root.img
     # cryptsetup luksHeaderBackup /dev/disk/by-partlabel/cryptuser --header-backup-file /mnt/backupcrypt/user.img
     
     # cryptsetup open /dev/disk/by-partlabel/cryptroot root
     # cryptsetup open /dev/disk/by-partlabel/cryptuser user
     # cryptsetup open /dev/disk/by-partlabel/cryptswap swap
  ```
  - Unmount, close and remount to make sure that everything is working smoothly
  - Mount and make file systems
    ```
      # mkfs.ext4 /dev/mapper/root
      # mkfs.ext4 /dev/mapper/user
      # mkswap -L swap /dev/mapper/swap
            
      # mount /dev/mapper/root /mnt
      # mount -L /dev/mapper/user /mnt/home
      # swapon -L swap
    ```
- Generate fstab
  - Use `LABEL=swap swap swap defaults 0 0` for swap
- Chroot
  - ```
      # arch-chroot /mnt
      # export PS1="(chroot) ${PS1}"
    ```
- `pacstrap` the following
  - `pacstrap /mnt base base-devel linux linux-firmware nano sudo intel-ucode` 
  - Linux install | `linux linux-firmware`
  - Processor Microcode | `intel-ucode`
  - Text Editor | `nano nano-syntax-highlighting`
  - Network Manager | `networkmanager` and enable service
  - Secure boot tool | `sbctl`
- Systemd-boot
  - https://wiki.archlinux.org/title/Systemd-boot
  - Use `/boot` as mount point and run `bootctl install`
  - Add in at `/boot/loader/entries/arch.conf`
    ```
      title   Arch Linux
      linux   /vmlinuz-linux
      initrd  /intel-ucode.img
      initrd  /initramfs-linux.img
      options rd.luks.name=ROOT_UUID=root root=/dev/mapper/root rd.luks.name=USER_UUID=user rd.luks.name=SWAP_UUID=swap rd.luks.options=SWAP_UUID=tpm2-device=auto resume=/dev/mapper/swap rw quiet splash acpi_backlight=vendor
    ```
   - Same for fallback
  - Use the already present UEFI partition, if there
- Secure Boot
  - https://wiki.archlinux.org/title/Unified_Extensible_Firmware_Interface/Secure_Boot#sbctl
  - Verify with `sbctl status`
  - `sbctl create-keys`
  - `sbctl enroll-keys -m` and check status again
  - Sign files from `sbctl verify` with `sbctl sign -s /path/to/file`
  - Check everything works with `sbctl status`
  - Add pacman hooks from https://wiki.archlinux.org/title/Systemd-boot#pacman_hook
  - Re-enable Secure Boot
- Disk Encryption
  - https://wiki.archlinux.org/title/Dm-crypt/Encrypting_an_entire_system#LUKS_on_a_partition
  - Configure `/etc/mkinitcpio.conf`, and add `systemd keyboard sd-vconsole sd-encrypt` presence
  ```
    HOOKS=(base udev systemd keyboard autodetect modconf kms sd-vconsole block sd-encrypt filesystems fsck)
  ```
- Swap Encryption and Hibernation | `tpm2-tss tpm2-tools` (TODO update to hibernation friendly method, use TPM)
  - Configure `/etc/mkinitcpio.conf`, and add `resume` after `udev`
  - Check `cat /sys/class/tpm/tpm0/tpm_version_major` has `2`
  - List available TPMs at `systemd-cryptenroll --tpm2-device=list`
  - Enroll key with `systemd-cryptenroll --tpm2-device=auto --tpm2-pcrs=0,7 /dev/disk/by-partlabel/cryptswap`
  - Test that it works with `/usr/lib/systemd/systemd-cryptsetup attach swap /dev/disk/by-partlabel/cryptswap - tpm2-device=auto`
- Generate initramfs

- Clean Up Boot Options
  - `efibootmgr` can list and remove them as necessary

## Post-Boot
- Add user
  `# useradd -m $user; passwd $user; usermod -aG wheel,audio,video,optical,storage $user`
- Add wheel group to sudoers | `sudo`
  - Uncomment `# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL:ALL) ALL`
- git, ssh/gpg | `git openssh github-cli`
  ```
     $ gh auth login
     $ ssh-keygen -t ed25519 -C "$email"; ssh-add ~/.ssh/id_ed25519
     $ gh ssh-key add ~/.ssh/id_ed25519.pub --title $hostname
     $ gcl git@github.com:Incompleteusern/dotfiles.git
     $ gpg --full-generate-key
     $ gpg --list-secret-keys --keyid-format=long
     $ git config --global user.signingkey $KEY 
     $ git config --global commit.gpgsign true
     $ git config --global user.email "$email"
     $ git config --global user.name "$name"
  ```
- Run `initpackage.sh` and then `init.sh`

## Auto
- yay | `base-devel`
- Mirror management | `reflector`
  - Set US as country
  - Enable `reflector.timer`
- Enable Color, ILoveCandy, VerbosePkgLists, multilib and ParallelDownloads in /etc/pacman.conf
- Make `makepkg` multithread
  - https://unix.stackexchange.com/questions/268221/use-multi-threaded-make-by-default
- zshrc | `zsh`
- Pacman Utils | `paccache pacgraph`
- NetworkManager stuff
  - Add local host to /etc/hosts
  - https://wiki.archlinux.org/title/Network_configuration#localhost_is_resolved_over_the_network
  - Use 1.1.1.1, 8.8.8.8 for default dns, mac address randomization
  - Maybe use `systemd-resolvd` one day, if `cups` works with it 
- Make closing lid initiate sleep in `/etc/systemd/logind.conf` with `HandleLidSwitch=suspend` if necessary

# Desktop

## TODO

## Manual
- Add `sd-plymouth` hook when sd-encrypt actually used
  - Configure `/etc/mkinitcpio.conf`, and add `systemd keyboard sd-vconsole sd-encrypt` presence
  ```
    HOOKS=(base udev systemd sd-plymouth keyboard autodetect modconf kms sd-vconsole block sd-encrypt filesystems fsck)
  ```
- Fcronjob for wall paper timer and ewww
  - ```
    systemctl enable fcron.service
    systemctl enable fcrontimer.service
    fcrontab -e
    ```
  - Then (TODO this is terrible)
    ```
    SHELL=/usr/bin/zsh
    PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
    XDG_RUNTIME_DIR=/run/user/1000
    WAYLAND_DISPLAY=wayland-1
    &runatreboot */15 * * * * source ~/.env; bash ~/.scripts/wallpaper/wallpaper.sh

    &runatreboot * * * * * eww -c ~/.config/eww/bar update clock_minute="$(date +\%M)"
    &runatreboot 0 * * * * eww -c ~/.config/eww/bar update clock_time="$(date +\%I)"
    &runatreboot 0 0 * * * eww -c ~/.config/eww/bar update clock_date="$(date '+%m/%d')"; eww -c ~/.config/eww/bar update calendar_day="$(date '+%d')"
    &runatreboot 0 0 1 * * eww -c ~/.config/eww/bar update calendar_month="$(date '+%m')"
    &runatreboot 0 0 1 1 * eww -c ~/.config/eww/bar update calendar_year="$(date '+%Y')"
    ```
    - TODO automate this

## Auto
- Polkit | `polkit-kde-agent` 
- Compositor | `hyprland-git qt5-wayland qt6-wayland hyprpicker-git` 
- Wallpapers | `swww-git` 
- Notification System | `dunst libnotify` 
- Status Bars | `eww-wayland-git`
- Pipewire | `pipewire wireplumber pipewire-pulse pipewire-jack `
- XDG Integration | `xdg-utils xdg-desktop-portal-hyprland`
- Terminal | `alacritty-git`
- App Launcher | `rofi-lbonn-wayland-git papirus-icon-theme-git sif-git networkmanager-dmenu-git ttf-jetbrains-mono-nerd ttf-jetbrains-mono ttf-iosevka-nerd` 
- Font Input | `fcitx5 fcitx5-chinese-addons fcitx5-configtool fcitx-gtk fcitx5-pinyin-zhwiki fcitx5-qt`
- Session Locker | `swaylockd swaylock-effects-git swayidle-git`
- Display Manager | `sddm`
- Color Temperature | `gammastep-git`
- Booting Animation | `plymouth-git`

# Utilities
## Manual
- Order Chinese as priority for Noto CJK
  - https://wiki.archlinux.org/title/Localization/Simplified_Chinese#Chinese_characters_displayed_as_variant_(Japanese)_glyphs
  - TODO automate that shit

## Auto
- Desktop Control | `brightnessctl`
- Fonts | `ttf-ms-fonts noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra ttf-material-icons-git ttf-symbola`
  - Set Chinese as font priority
- Screenshots | `grim slurp wl-clipboard jq` (grimblast)
- Scheduler | `cronie`
- Command Line
  - Replace cat | `bat`
  - Replace ls | `exa`
  - Find | `fzf`, `fd`
  - Requests | `httpie`
  - Ping | `gping-git`
  - Git diff | `git-delta-git`
- power | `tlp tlp-rdw`
- spotify integration | `playerctl`
- volume control | `pamixer`
- System Information | `htop neofetch-git duf`
# Silly
## Manual
## Auto
- fortune | `fortune`
- cmatrix | `cmatrix-git`
- ascii art `ascii-rain-git asciiquarium sl donut.c`

# Applications

## Manual
- Use catpuccin mocha lavender for firefox, vscode.
  - TODO automate that shit
- Use `cups` for printer stuff.
  - Do https://wiki.archlinux.org/title/Avahi#Hostname_resolution
  - TODO automate, move to installation section too?
- Enable firefox hardware acceleration, reopen tabs on close
  - TODO automate?

## Auto
- Firefox | `firefox`
- Discord | `discord-electron-bin discord-screenaudio discord-update-skip-git`
- Prism Launcher | `prismlauncher`
- Steam | `steam`
- Vs Code | `visual-studio-code-bin`
- VPN | `openvpn protonvpn-gui`
- Spotify |`spotify-edge spotifywm spotify-adblock-git spicetify`
