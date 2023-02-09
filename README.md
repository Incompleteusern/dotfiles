![image](https://user-images.githubusercontent.com/58920010/217399494-81f74489-fb94-4b74-8b91-99acd16901cc.png)
![image](https://user-images.githubusercontent.com/58920010/216701421-588d2a53-43ef-4c46-aba3-798434cddb06.png)

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
- `sync.sh` which syncs bundled github repos into local files
- `init.sh` which installs the github repo into an arch install

## TODO

TODO:
- Swap hibernation encryption support based on https://gist.github.com/orhun/02102b3af3acfdaf9a5a2164bea7c3d6#known-issues
- Learn tmux
- TODO renable secure boot support
- Change mouse or something idk
- Do redshift alternative
- Customize oh-my-fsh more
- Configs for desktop
  - Wallpaper script time!!!!
  - EWW
    - Add customization if mute
    - Finish spotify integration using --follow
- Write a python script to handle bundling other repos in this
- Screensharing, App Launchers, App Clients, Color Pickers
    - aka Configure Rest of Desktop
- Customize firefox + fork mozilla? 
- Go through general preference :SOB:
- Add disk encryption
  - https://wiki.archlinux.org/title/Dm-crypt/Device_encryption with sector-size
  - Do this in February when wifi-adapter is natively supported by udev
- AI gen might be fun for wall paper
- dhcpcd, blueman and wpa_supplicant?

# Installation

## Manual
### Pre-Boot
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
- Mirror management | `reflector`
  - Set US as country
  - Enable `reflector.timer`
  - TODO automate that shit
- Add user
  `# useradd -m $user; passwd $user; usermod -aG wheel,audio,video,optical,storage $user`
- Add wheel group to sudoers | `sudo`
  - Uncomment `# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL:ALL) ALL`
- git, ssh/gpg | `git openssh github-cli`
  ```
     $ gh auth login
     $ ssh-keygen -t ed25519 -C "$email"; ssh-add ~/.ssh/id_ed25519
     $ gh ssh-key add ~/.ssh/id_ed25519.pub --title $hostname
     $ git clone git@github.com:Incompleteusern/dotfiles.git
     $ gpg --full-generate-key
     $ gpg --list-secret-keys --keyid-format=long
     $ git config --global user.signingkey $KEY 
     $ git config --global commit.gpgsign true
     $ git config --global user.email "$email"
     $ git config --global user.name "$name"
  ```
  - TODO automate this
- Run `init.sh`
- Make closing lid initiate sleep in `/etc/systemd/logind.conf` with `HandleLidSwitch=suspend` if necessary

## Auto
- Enable Color, ILoveCandy and ParallelDownloads in /etc/pacman.conf
- yay | `base-devel`
- add ~/script to path
- zshrc | `zsh`
- Pacman Utils | `paccache pacgraph`
- Add local host to /etc/hosts
  - TODO url link

# Desktop

## TODO
- Polkit | `polkit-kde-agent` 

## Manual

## Auto
- Compositor | `hyprland-git` 
- Wallpapers | `swww-git` 
- Notification System | `dunst libnotify` 
- Status Bars | `eww-wayland-git`
- Pipewire | `pipewire wireplumber pipewire-pulse pipewire-jack `
- XDG Integration | `xdg-utils xdg-desktop-portal-wlr`
- Terminal | `alacritty-git`
- App Launcher | `rofi-lbonn-wayland-git papirus-icon-theme-git sif-git networkmanager-dmenu-git ttf-jetbrains-mono-nerd ttf-jetbrains-mono ttf-iosevka-nerd` 
- Font Input | `fcitx5 fcitx5-chinese-addons fcitx5-configtool fcitx-gtk fcitx5-pinyin-zhwiki fcitx5-qt`
- Session Locker | `swaylockd swaylock-effects-git swayidle-git`
- Display Manager | `sddm`

# Utilities
## Manual
- Order Chinese as priority for Noto CJK
  - https://wiki.archlinux.org/title/Localization/Simplified_Chinese#Chinese_characters_displayed_as_variant_(Japanese)_glyphs
  - TODO automate that shit

## Auto
- Desktop Control | `brightnessctl`
- fonts | `ttf-ms-fonts noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra ttf-material-icons-git ttf-symbola`
  - Set Chinese as font priority
- screenshots | `grim slurp wl-clipboard jq` (grimblast)
- cli
  - Replace cat | `bat`
  - Replace ls | `exa`
  - Replace find | `fzf`, `fd`
  - Requests | `httpie`
  - Ping | `gping-git`
- power | `tlp tlp-rdw`
- spotify integration | `playerctl`
- volume control | `pamixer`
- System Information | `htop neofetch-git duf`
# Silly
## Manual
## Auto
- cbonsai | `cbonsai-git`
- donut.c | `donut.c`
- cmatrix | `cmatrix-git`
- sl | `sl`

# Applications

## Manual
- Use catpuccin mocha lavender for firefox, vscode, bd, and spicetify.
  - TODO automate that shit
- Use `cups` for printer stuff.
- Enable firefox hardware acceleration, reopen tabs on close

## Auto
- Firefox | `firefox`
- Discord | `discord-electron-bin discord-screenaudio betterdiscordctl`
- Prism Launcher | `prismlauncher`
- Steam | `steam`
- Vs Code | `visual-studio-code-bin`
- VPN | `openvpn protonvpn-gui`
- Spotify |`spotify spotifywm spotify-adblock-git spicetify`
