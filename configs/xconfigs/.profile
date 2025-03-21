export SHELL="/bin/zsh"
export XDG_DATA_DIRS="$XDG_DATA_DIRS:/var/lib/flatpak/exports/share"
export DATE=$(date +%Y%m%d)
export PATH="$PATH:$(du "$HOME/bin/" | cut -f2 | tr '\n' ':' | sed 's/:*$//;s|/$||')"
export PATH="$PATH:$HOME/.local/bin/"
export PATH="$PATH:/usr/local/texlive/2022/bin/x86_64-linux/"
export MANPATH="$MANPATH:/usr/local/texlive/2022/texmf-dist/doc/man/"
export INFOPATH="$MANPATH:/usr/local/texlive/2022/texmf-dist/doc/info/"
export PATH="$PATH:/usr/local/MATLAB/R2019b/bin/"
export PATH="$PATH:/usr/local/MATLAB/R2019b/bin/glnxa64"
export PATH="$PATH:$HOME/.cargo/bin/"
export PRINTER=HP-LaserJet-Pro-MFP-M127fn
export MPD_HOST="$HOME/.config/mpd/socket"
export SCRIPTSFOLDER="$HOME/bin"
export SUDO_ASKPASS=$SCRIPTSFOLDER/askPass
# export ALTERNATE_EDITOR="emacsclient -s $HOME/.emacs.d/server/server -t"
export ALTERNATE_EDITOR="emacsclient -t"
# export TERMINAL="st"
export TERMINAL="alacritty"
export EDITOR="emacs -nw"
# export VISUAL="st -e nvim"
# export EDITOR="emacsclient -ct -s $HOME/.emacs.d/server/server"
export EDITOR="emacsclient -ct"
export VISUAL="emacsclient -a '$TERMINAL -e vim'"

export NOTMUCH_CONFIG="$HOME/.config/notmuch/config"

export OLDPWD=$HOME


# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'


mpd

# echo "$0" | grep "zsh$" >/dev/null && [ -f ~/.zshrc ] && source "$HOME/.zshrc"

# echo "$0" | grep "bash$" >/dev/null && [ -f ~/.bashrc ] && source "$HOME/.bashrc"
# [ "$(tty)" = "/dev/tty1" ] && ! pgrep -x i3 >/dev/null && exec startx

# sudo -n loadkeys ~/.scripts/ttymaps.kmap 2>/dev/null
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

# >>> juliaup initialize >>>

# !! Contents within this block are managed by juliaup !!

case ":$PATH:" in
    *:/home/accacio/.juliaup/bin:*)
        ;;

    *)
        export PATH=/home/accacio/.juliaup/bin${PATH:+:${PATH}}
        ;;
esac

# <<< juliaup initialize <<<
