# Neovim

## Installation (Ubuntu and Debian only, skip this if on Arch)
1. Go to [Neovim Github's page](https://github.com/neovim/neovim/releases/tag/v0.9.5) and download the tarbal of the latest stable release (version > 0.5 otherwise init.lua won't load properly')
2. Move the tarbal in the appropriate folder and extract it
```bash
mv nvim-linux64.tar.gz ~/.local/bin/ && cd ~/.local/bin/
tar xzvf nvim-linux64.tar.gz
rm -fr xzvf nvim-linux64.tar.gz
```
3. Create a symlink to the binary
```bash
ln -s ./nvim-linux64/bin/nvim ./nvim
```
make sure that the location of the symlink is into the `PATH` variable otherwise add this
```bash
export PATH=$PATH:~/.local/bin:
```
into the `.bashrc`

## Configuration
1. Copy your dotfiles into the `~/.config/` folder 
```bash
git clone git@github.com:papadeiv/dotfiles.git
cp -r ./dotfiles/nvim/ ./.config/nvim/
```

2. First run: when you type `nvim` for the first time you will be greeted with a bunch of error messages due to the various plugins in `~/.config/nvim/` not being installed yet; press `Enter`. If Packer is not launched automatically you will have to type `:PackerSync` and then `:PackerCompile`

3. The next run should be fully working.
