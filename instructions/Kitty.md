# Kitty terminal

## Installation (Ubuntu and Debian only, skip this if on Arch)
1. Install kitty 
```bash
sudo apt install kitty -y
```
2. Install starship
```bash
curl -sS https://starship.rs/install.sh | sh
```

## Configuration
1. Set kitty as the default terminal (Ubuntu only, skip if on Arch)
```bash
sudo update-alternatives --config x-terminal-emulator
```
2. Copy your dotfiles in the `~/.config/` directory
```bash
cp ./dotfiles/.bashrc .
cp ./dotfiles/kitty ./.config/
cp ./dotfiles/starship ./.config/
```
3. Edit the `.config/kitty/kitty.conf` file accordingly (`font_size` entry is on line `27`)

4. To change to a new colorscheme type `kitten themes` in the terminal and scroll to the one you like.
