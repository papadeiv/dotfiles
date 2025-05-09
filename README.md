# Setup 

## Install and post-install instructions

 - [Archlinux](./instructions/ArchLinux.md)
 - [Ubuntu](./instructions/Ubuntu.md)

## Workflow

### System shortcuts

#### File explorer
- `Meta + e` = launch
- `Ctrl + t` = open new tab
- `Ctrl + w` = close tab
- `Ctrl + Shift + Tab` = walk through tabs
- `Ctrl + Shift + n` = create new folder
- `Alt + Left arrow` = go back

#### Rofi
- `Alt + Space` = launch

### Neovim keybindings, snippets and shortcuts

#### Normal mode
- <leader>w = write/save file
- <leader>q = close file 
- <S-Tab> = shuffle between buffers 
- <S-G> = go to EOF 
- gg = go to BOF 
- i = go insert mode
- 1 = go to the beginning of the line
- 2 = go to the end of the line
- w = shuffle forward by words
- b = shuffle backward by words

#### LaTex (vimtex)
- \ll = compile target
- \ls = change target to current .tex
- <Tab> = trigger snippet autocompletion
- <S-Tab> = suffle through snippet insertion points
##### Snippets
- ss = superscript
- uu = underscript
- eqref = reference equation
- ref = reference anything
- sys = system of equations
- fdef = map definition
- ex = Example environment
- excont = Continued example
- thm = Theorem environment
- thmcont = Theorem continued
- interp = Interpretation environment
- interpcont = Continued interpretation

#### Zotero (zotcite)
- <leader>zi = print title of the ref
- <leader>za = print full details of the ref
- <leader>zo = openf PDF of the ref
- <C-Space> = complete the ref

#### File explorer (nvim-tree)
- <leader>e = toggle tree visibility
- <leader>tf = open floating terminal
- i = Open file/folder

## Troubleshooting

### CPU overloading: syslog
1. Get the name of the process that is using a lot of CPU
```bash
sudo tail /var/log/syslog
```
2. Kill it
```bash
killall <name_of_the_process>
```
3. Clear the log file
```bash
sudo truncate -s 0 /var/log/syslog
```

### Black screen after reboot (Arch)
You need to revert some of the changes prior to the reboot (presumably a theme of the display manager in KDE Plasma 6)
1. Login to a `tty` by pressing `Ctrl + Alt + F2` or `Ctrl + Alt + F6`

2. Set `Breeze` as the system theme
```bash
echo -e “[Theme]\nCurrent=breeze” | sudo tee /etc/sddm.conf.d/theme.conf
```

3. Restart `sddm`
```bash
sudo systemctl restart sddm
```

4. Reboot if necessary
```bash
reboot
```

## TODOs 

- [] Learn the remaining keybindings in Neovim
    - Capitalise character
    - Scroll quickly through the file
    - Redo
- [] Customise [grub](https://www.reddit.com/r/LinuxPorn/comments/1kehamn/gorgeousgrub_collection_of_beautiful/): good themes are [arcade](https://github.com/nobreDaniel/dotfile) and [catppuccin](https://github.com/catppuccin/grub) 
- [] Customise the splash screen 

## Notable/Inspiring rices 

- [GNOME + Pop! Os](https://www.reddit.com/r/unixporn/comments/1kg3u5i/gnome_riced_browser_to_match_terminal_and_pdf/): theme customisation for the pdf viewer and the browser in GNOME
- [GNOME + Arch](https://www.reddit.com/r/unixporn/comments/1ker7rd/gnome_my_best_gnome_rice_yet/): rounded window corners in GNOME
- [bspwm + Arch](https://www.reddit.com/r/unixporn/comments/1k7c8i1/bspwm_i_dont_use_anime_wallpapers/): theme customisation of chromium
- [Hyprland + Arch](https://www.reddit.com/r/LinuxPorn/comments/1jzvuiy/hyprland_arch_hyprland_black_metal_gorgoroth/): theme customisation of the logout menu
- [Manjaro + i3](https://www.reddit.com/r/unixporn/comments/1fc5zt6/i3_some_updates_to_my_config/): theme customisation of Rofi and setting it as calculator also uses thunar as the FM (this is the italian guy)
- [Hyprland + Arch](https://www.reddit.com/r/unixporn/comments/1dofro9/hyprland_minimal_but_stable_and_very_functional/): neovim welcome page customisation
- [GNOME + Ubuntu](https://www.reddit.com/r/unixporn/comments/16j8goo/gnome_ubuntu_2304_should_i_make_auto_installation/): insane ricing on Ubuntu
- [GNOME + Arch](https://www.reddit.com/r/unixporn/comments/16dej2u/gnome/): the guy with _L'Occhio Occidentale'_ wallpaper
