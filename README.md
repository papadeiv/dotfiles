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
