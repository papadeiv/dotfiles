# ArchLinux 

Always follow the steps and refer to the detailed [installation guide](https://wiki.archlinux.org/title/Installation_guide) on the official ArchLinux Wiki. 

## Pre-installation
1. Have a separate PC available to you to read the instructions, check tutorials etc...
2. Have a USB stick of at least 16 GB 
3. Download and install balenaEtcher
4. Format the USB stick via the Disks app (on Linux) using the FAT type
5. Download the [archlinux iso](https://archlinux.org/download/)
6. Flash the iso onto the USB stick with balenaEtcher
7. Once completed the flash, safely remove the USB stick
8. On the target PC where you want to install ArchLinux, disable [SecureBoot](https://wiki.archlinux.org/title/Unified_Extensible_Firmware_Interface/Secure_Boot#Disabling_Secure_Boot)
```bash
Settings > Update & Security > Recovery > Advance startup (Restart now) > Troubleshoot > Advanced options > UEFI Firmware settings (Restart)
```

## Installation
1. Reboot your system and [access the UEFI/BIOS](https://wiki.archlinux.org/title/Unified_Extensible_Firmware_Interface/Secure_Boot#Before_booting_the_OS) of your system's firmware. On Windows this can be done without rebooting: 
```bash
Settings > Update & Security > Recovery > Advance startup (Restart now) > Troubleshoot > Advanced options > UEFI Firmware settings (Restart)
```
2. In the UEFI change the boot priority order to point to the flashed USB stick as the first device. Typically it would be:
```bash
Startup > Boot > Boot priority order 
```
Save and exit.
3. Upon rebooting you'll be prompted with the boot loader. Select _Arch Linux install medium_ and press __Enter__
4. After the safety checks you'll be presented with the `zsh` terminal and logged in as `root` in the virtual console
5. [Connect to the internet](https://www.debugpoint.com/connect-wifi-terminal-linux/) via Wifi
```bash
iwctl
[iwd]# device list                       // Lists the device in the network manager
[iwd]# station wlan0 scan                // Outputs nothing 
[iwd]# station wlan0 get-networks        // It will lists the available wifi networks 
[iwd]# station wlan0 connect wifi_name   // Select the wifi_name network from the list (security type has to be psk) 
[iwd]# exit 
ping archlinux.org                       // Check that the connection is established
// Ctrl + c                              // Stops the ping command 
```
6. Update `pacman` mirror list
```bash
sudo rm -R /var/lib/pacman/sync          // To avoid GPGME error on the following command
pacman -Syy
```
7. Type `archinstall` and press __Enter__ (the rest of the instructions can be found [here](https://www.debugpoint.com/archinstall-guide/))
8. If the `archinstall` script allowed to select before hand your desktop environment then at the end you can select `no` to boot as `chroot` and then `shutdown -h now`

## Post-install
Immediately after rebooting and logging into your new arch installation open the terminal (`Konsole` if you choose the KDE Plasma DE)

1. Update the system
```bash
sudo pacman -Syu
```
2. Preparation to instal `yay` which is an [AUR](https://aur.archlinux.org/packages) helper (essentially it helps you find and install a lot more packages) 
```bash
sudo pacman -S base-devel git
```
3. Install `yay`
```bash
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makapkg -si
cd ../ && rm -r yay-bin
```
4. Update once more
```bash
sudo yay -Syu
```
5. Install a bunch of stuff: 
  - browser, editor, terminal, shell prompt and app launcher
  ```bash
  sudo yay -S google-chrome neovim wl-clipboard python-pynvim kitty extra/starship rofi-wayland 
  ```
  - [nerd fonts](https://github.com/ryanoasis/nerd-fonts) icons and logos
  ```bash
  sudo yay -S extra/otf-geist-mono-nerd extra/texlive-fontsextra extra/xorg-fonts-misc extra/freetype2 extra/adwaita-icon-theme extra/bdf-unifont aur/siji-git extra/ttf-linux-libertine 
  ```
  - code development tools
```bash
sudo yay -S base-devel juliaup cmake extra-cmake-modules openssh man qt6-tools gparted ntfs-3g kio-extras
```
  - research tools
  ```bash
  sudo yay -S okular zathura zathura-pdf-mupdf zathura-djvu zathura-ps xournalpp
  ```
  - LaTeX and Biber 
  ```bash
  sudo yay -S texlive-basic texlive-bibtexextra texlive-binextra texlive-fontsextra texlive-fontsrecommended texlive-fontutils texlive-latex texlive-latexextra texlive-latexrecommended texlive-mathscience texlive-pictures texlive-publishers biber 
  ```
  - multimedia packages
  ```bash
  sudo pacman -S mpd rmpc
  sudo yay -S shotwell vlc
  ```

6. Create the `/mnt/tmp/` directory for mounting/unmounting USB external devices
```bash
sudo mkdir /mnt/tmp
```

7. Install the bluetooth utilities
```bash
sudo yay -Sy bluez bluez-utils bluez-deprecated-tools
```
Run `lsmod` to check that the relative kernel module is loaded (you should look for `bluetooth` and the module is named `btusb`) and then enable it `systemctl start bluetooth.service`.

8. Set the correct timezone if wrong
```bash
timedatectl status
timedatectl list-timezones 
timedatectl set-timezone your_zone/your_subzone 
```

9. Update once more and reboot
```bash
sudo yay -Syu
reboot
```

## Configuration
Follow the steps below in order: each step has multiple choices depending on your customisation.
- Configure the browser (whichever choice, sign into your Google account and enable sync-in as first thing)
  - Chrome
  - Firefox
- Configure [Git & Github](GitHub.md)
- Text editor
  - [Neovim](Neovim.md)
- Terminal
  - [Kitty](Kitty.md)
  - Alacritty
- Desktop environment
  - [KDE Plasma](KDEPlasma.md)
- App launcher
  - [Rofi](Rofi.md)
  - dmenu
- Install and configure [Julia](Julia.md)
- Configure the [SSH](SSH.md) connection
