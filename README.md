## Thanks to

- https://github.com/scotus-1/dotfiles for format and what to use
- https://github.com/flick0/dotfiles for various configs, old waybar
- https://github.com/Saimoomedits/eww-widgets for the top bar
  - Modified for catppuccin theming, hyprland and spotify 
  - TODO move to fork
- https://github.com/catppuccin for the pastel theming over basically everything I can touch
  - For rofi, deathmonde specficially is used
- https://wiki.archlinux.org/title/User:Bai-Chiang/Installation_notes and https://gist.github.com/orhun/02102b3af3acfdaf9a5a2164bea7c3d6, https://www.reddit.com/r/archlinux/comments/zo83gb/how_i_setup_secure_boot_for_arch_linux_simple/, and https://gist.github.com/michaelb081988/0e3f1bbd3bb04fb34c0726e28da2a934 for extended installation notes over encryption and so forth
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
- Document https://wiki.archlinux.org/title/OpenSSH#Deny
- Document https://wiki.archlinux.org/title/Intel_graphics, https://wiki.archlinux.org/title/Hardware_video_acceleration#Configuring_applications, early kmsc
- https://www.reddit.com/r/archlinux/comments/116dd58/is_it_possible_to_default_remove_make/
- Firewall, proton-ge-custom-bin, libwebcam-git
- Document time sync
- https://wiki.archlinux.org/title/Zsh#Prompts
- https://wiki.archlinux.org/title/Improving_performance
- Learn tmux
- Change mouse or something idk
- Customize oh-my-zsh more
- Configs for desktop
  - Wallpaper script time!!!!
  - EWW
    - Add customization if mute
- Customize firefox + fork mozilla? 
- Do disk encryption, unified kernel image
- Add disk encryption
  - https://wiki.archlinux.org/title/Dm-crypt/Device_encryption with sector-size
  - Do this in February when wifi-adapter is natively supported by udev
- Swap hibernation encryption support based on https://gist.github.com/orhun/02102b3af3acfdaf9a5a2164bea7c3d6#known-issues
- AI gen might be fun for wall paper

# Installation

## Manual
### Pre-Boot
- Standard installation

- Disable Secure Boot/Check it is disabled
  - `# bootctl status | grep "Secure Boot"`
- Right now, temporary android tether to set up and get driver rtw89 manually
  - Wait till kernel 6.2
- Three partitions and encryption (UNTESTED!!!)
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
  - Use `LABEL=swap swap swap defaults 0 0` for swap (UNTESTED!!!)
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
- Systemd-boot (KERNEL PARAMS UNTESTED!!!)
  - https://wiki.archlinux.org/title/Systemd-boot
  - Use `/boot` as mount point and run `bootctl install`
  - Add in at `/boot/loader/entries/arch.conf`
    ```
      title   Arch Linux
      linux   /vmlinuz-linux
      initrd  /intel-ucode.img
      initrd  /initramfs-linux.img
      options rd.luks.name=ROOT_UUID=root root=/dev/mapper/root rd.luks.name=USER_UUID=user rd.luks.name=SWAP_UUID=swap resume=/dev/mapper/swap rw quiet splash acpi_backlight=vendor
    ```
   - Same for fallback
- Disk Encryption (UNTESTED!!!)
  - https://wiki.archlinux.org/title/Dm-crypt/Encrypting_an_entire_system#LUKS_on_a_partition
  - Configure `/etc/mkinitcpio.conf`, and add `systemd keyboard sd-vconsole sd-encrypt` presence
  ```
    HOOKS=(base udev systemd keyboard autodetect modconf kms sd-vconsole block sd-encrypt filesystems fsck)
  ```
  - Regenerate initramfs
- Clean Up Boot Options
  - `efibootmgr` can list and remove them as necessary

## Post-Boot

- Secure Boot | `sbctl`
  - https://wiki.archlinux.org/title/Unified_Extensible_Firmware_Interface/Secure_Boot#sbctl
  - Verify with `sbctl status`, reset keys and enable set up mode
  - `sbctl create-keys`
  - `sbctl enroll-keys -m` and check status again
  - Sign files with `sbctl sign-all`
  - Check everything works with `sbctl status` and `sbctl list-files`
  - Add pacman hooks from https://wiki.archlinux.org/title/Systemd-boot#pacman_hook

- Unified Kernel Image (UNTESTED!!!)
  - Move kernel parameters to `/etc/kernel/cmdline`
  - Make bundled image with `sbctl bundle -i /boot/intel-ucode.img  --save /boot/archlinux.efi`
  - Change default systemd-boot, remove `arch.conf` (?)
  - Re-enable Secure Boot
- Swap Encryption and Hibernation | `tpm2-tss tpm2-tools` (UNTESTED!!!)
  - Configure `/etc/mkinitcpio.conf`, and add `resume` after `udev`
  - Check `cat /sys/class/tpm/tpm0/tpm_version_major` has `2`
  - List available TPMs at `systemd-cryptenroll --tpm2-device=list`
  - Enroll key with `systemd-cryptenroll --tpm2-device=auto --tpm2-pcrs=0,7 /dev/disk/by-partlabel/cryptswap`
  - Test that it works with `/usr/lib/systemd/systemd-cryptsetup attach swap /dev/disk/by-partlabel/cryptswap - tpm2-device=auto`
  - Add `rd.luks.options=SWAP_UUID=tpm2-device=auto` to kernel parameters in `/etc/kernel/cmdline`
  - Regenerate Image with `sbctl generate-bundles --sign`

- Add user
  `# useradd -m $user; passwd $user; usermod -aG wheel,audio,video,optical,storage $user`
- Add wheel group to sudoers | `sudo`
  - Use `visudo`
  - Uncomment `# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL:ALL) ALL`
  - Add
    ```
    Defaults      env_reset
    Defaults      editor=/usr/bin/rnano, !env_editor
    Defaults passwd_timeout=0
    ```
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
  - Use basic `systemd-resolvd`
- Make closing lid initiate sleep

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

    !exesev,bootrun

    */15 * * * * source ~/.env; bash ~/.scripts/wallpaper/wallpaper.sh

    * * * * * eww -c ~/.config/eww/bar update clock_minute="$(date +\%M)"
    0 * * * * eww -c ~/.config/eww/bar update clock_time="$(date +\%I)"
    0 0 * * * eww -c ~/.config/eww/bar update clock_date="$(date '+%m/%d')"; eww -c ~/.config/eww/bar up>
    0 0 1 * * eww -c ~/.config/eww/bar update calendar_month="$(date '+%m')"
    0 0 1 1 * eww -c ~/.config/eww/bar update calendar_year="$(date '+%Y')"
    ```
  - TODO automate this
- Add `OWM_API_KEY` to be exported frm .env

## Auto
- Compositor | `hyprland-git qt5-wayland qt6-wayland` 
- XDG Integration | `xdg-utils xdg-desktop-portal-hyprland`
- Status Bars | `eww-wayland-git`
- Wallpapers | `swww-git` 
- Notification System | `dunst-git libnotify` 
- Session Locker | `swaylockd swaylock-effects-git swayidle-git`
- Font Input | `fcitx5-git fcitx5-chinese-addons-git fcitx5-configtool-git fcitx-gtk-git fcitx5-pinyin-zhwiki fcitx5-qt`
- App Launcher | `rofi-lbonn-wayland-git papirus-icon-theme-git sif-git networkmanager-dmenu-git` 
- Terminal | `alacritty-git`
- Pipewire | `pipewire-git wireplumber-git pipewire-jack-git pipewire-pulse-git`
- Display Manager | `sddm-git sddm-conf-git`
- Color Temperature | `gammastep-git`
- Booting Animation | `plymouth-git`
- Color Picker `hyprpicker-git`
- Polkit | `polkit-kde-agent` 

# Utilities
## Manual
- Order Chinese as priority for Noto CJK
  - https://wiki.archlinux.org/title/Localization/Simplified_Chinese#Chinese_characters_displayed_as_variant_(Japanese)_glyphs
  - TODO automate that shit

## Auto
- Desktop Control | `brightnessctl pamixer`
- Fonts | `ttf-ms-fonts noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra ttf-jetbrains-mono-nerd ttf-jetbrains-mono ttf-iosevka-nerd`
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
- System Information | `htop neofetch-git duf`
- crontab | `fcron`

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
- VPN | `openvpn protonvpn-gui networkmanager-openvpn`
- Spotify |`spotify-edge spotifywm spotify-adblock-git spicetify`
