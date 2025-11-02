# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

# End of preconfigured lines

HISTCONTROL=ignoredups:erasedups
HISTIGNORE="exit:clear"

alias la="ls -lA"
alias diff="diff --color=auto"
alias grep="grep --color=auto"
alias ip="ip --color=auto"

mkdircd () { mkdir -p $1 && cd $1; }
udots () {
    OLD="$(pwd)"
    cd ~/Documents/Programming/fedora-dots
    git fetch && git pull && ./install.sh
    cd "$OLD"
}
