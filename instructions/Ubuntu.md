# Ubuntu

## Pre-installation 
1. Download the distro.release.iso
2. Install either balenaEtcher or Rufus
3. Flash the iso onto a >16 GB USB sticker to make it bootable
4. Restart and boot from USB (access BIOS and reorder the boot order)
5. Follow the setup instructions
6. Comes pre-installed with : Python3, FDisk, man, Parted, tar, Vim, ssh

## Post-install
1. Remove all the bloat; some of them (thunderbird, rhytmbox etc...) can be removed via terminal
```bash
sudo apt list --install
sudo apt remove thunderbird
```
others have to be removed via Ubuntu Software (i.e. snap) which has therefore to be uninstalled last. Once done do
```bash
sudo apt autoremove
sudo apt purge
```
and then restart!
2. Update 
```bash 
sudo apt update
sudo apt upgrade
```
3. Install dev tools (approx 500 MB)
```bash
sudo apt install htop make
```
then do
```bash
sudo apt purge --auto-remove
```
and restart!

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
  - [GNOME](GNOME.md)
- App launcher
  - [Rofi](Rofi.md)
  - dmenu
- Install and configure [Julia](Julia.md)
- Configure the [SSH](SSH.md) connection
- Configure the [LaTeX](LaTeX.md) compiler
