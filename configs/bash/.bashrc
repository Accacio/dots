
. ~/.bashrc.d/configs.bash
. ~/.bashrc.d/alias.bash
. ~/.bashrc.d/prompt.bash
. ~/.bashrc.d/variables.bash
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
