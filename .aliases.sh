# If fasd is installed and in use, add a bunch of
# aliases for it.
if command -v fasd >/dev/null 2>&1; then
    # Any
    alias a='fasd -a'

    # Show/search/select
    alias s='fasd -si'

    # Directory
    alias d='fasd -d'

    # File
    alias f='fasd -f'

    # Interactive directory selection
    alias sd='fasd -sid'

    # Interactive file selection
    alias sf='fasd -sif'

    # cd - same functionality as j in autojump
    alias z='fasd_cd -d'

    # Interactive cd
    alias zz='fasd_cd -d -i'

    # Vim
    alias v='fasd -f -e vim'
fi

# Safe delete
if [ ! -d ~/.trash ]; then 
    mkdir ~/.trash
fi
del(){
	mv "$@" -t ~/.trash
}
alias rm='echo "rm disabled! Use del for safe delete"'

# More ls aliases.
#alias ll='ls -alF'
#alias la='ls -A'
#alias l='ls -CF'

# Replace 'ls' with exa if it is available.
if command -v exa >/dev/null 2>&1; then
    alias ls="exa --git --color=automatic"
    alias ll="exa --all --long --git --color=automatic"
    alias la="exa --all --binary --group --header --long --git --color=automatic"
    alias l='exa --git --color=automatic'
fi
