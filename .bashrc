# Set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

var="${var/#\~/$HOME}"
_WHITE=$(tput setaf 7)
_BOLD=$(tput bold)

PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h:\[\033[01;34m\] \W \[\033[01;32m\]>> ${_BOLD}${_WHITE} '

# USB mounting and unmounting
alias mountusb='sudo mount -t ntfs-3g /dev/sdb1 /mnt/tmp'
alias unmount='sudo umount /mnt/tmp'

# Zotero
alias zotero='cd ~/.config/zotero/ && zotero'

# Kitty image renderer
alias showme='kitty +kitten icat'

# Launch music deamon and its client
alias music='mpd && rmpc'

# Frequently visited directories
alias home='cd ~'

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Custom binaries directory to PATH variable
export PATH=$PATH:/usr/local/lib/anaconda3/bin:
export PATH=$PATH:/usr/local/lib/julia/bin:
export PATH=$PATH:~/.local/bin:

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/usr/local/lib/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/usr/local/lib/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/usr/local/lib/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/usr/local/lib/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

export STARSHIP_CONFIG=~/.config/starship/starship.toml 
eval "$(starship init bash)"
