# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/home/james/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME=""



# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

# Functions {{{
# =========
_has() {
    which $1>/dev/null 2>&1
}
# }}}

source $ZSH/oh-my-zsh.sh

export ZSH_CACHE_DIR=~/.oh-my-zsh/cache
if [ ! -d $ZSH_CACHE_DIR ]; then
    mkdir $ZSH_CACHE_DIR
fi


export HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew"
export HOMEBREW_CELLAR="/home/linuxbrew/.linuxbrew/Cellar"
export HOMEBREW_REPOSITORY="/home/linuxbrew/.linuxbrew/Homebrew"
export PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:$PATH"
export MANPATH="/home/linuxbrew/.linuxbrew/share/man:$MANPATH"
export INFOPATH="/home/linuxbrew/.linuxbrew/share/info:$INFOPATH"

# Check if its WSL linux or not
if [[ $(uname -r) == *-Microsoft ]]; then
    # do WSL stuff here
else
    # if we have dconf swap escape and caps lock
    if _has dconf; then
        dconf write /org/gnome/desktop/input-sources/xkb-options "['caps:swapescape']"
    fi

    if [[ ! -n ~/.fonts/SourceCodePro*(#qN) ]] ; then
        cd /tmp
        wget https://github.com/adobe-fonts/source-code-pro/archive/2.030R-ro/1.050R-it.zip

        if [ ! -d "~/.fonts" ] ; then
            mkdir ~/.fonts
        fi

        unzip 1.050R-it.zip

        cp source-code-pro-*-it/OTF/*.otf ~/.fonts/

        cd ~/

        # update font cache
        fc-cache -f -v
    fi

    # tell gnome terminal to use the new font
    gconftool-2 --set /apps/gnome-terminal/profiles/Default/font --type string "Source Code Pro Semibold Italic"
fi

# Aliases {{{
# =======
# Load our aliases.
if [ -f ~/.aliases.sh ]; then
    . ~/.aliases.sh
fi
# }}}

# fasd {{{
# =====
if _has fasd; then
    fasd_cache="$ZSH_CACHE_DIR/fasd-init-cache"
    if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
        fasd --init posix-alias zsh-hook zsh-ccomp zsh-ccomp-install >| "$fasd_cache"
    fi
    source "$fasd_cache"
    unset fasd_cache
fi
# }}}

# antibody
# =======
if _has antibody; then
    # If plugins have not been downloaded, then download and static load in future.
    if [[ ! -e "$HOME/.zsh_plugins.sh" ]]; then
        # Fetch plugins.
        antibody bundle < "$HOME/.zshplugins" > "$HOME/.zsh_plugins.sh"
    fi

    # Load plugins.
    source "$HOME/.zsh_plugins.sh"
fi
# }}}

# fasd
eval "$(fasd --init auto)"

fpath+=('/usr/local/lib/node_modules/pure-prompt/functions')

autoload -U promptinit; promptinit
prompt pure
#export CPLUS_INCLUDE_PATH="/opt/intel/opencl/SDK/include:/opt/AMDAPPSDK-3.0/include:$CPLUS_INCLUDE_PATH"

export LD_LIBRARY_PATH="/opt/AMDAPPSDK-3.0/lib:$LD_LIBRARY_PATH"
export AMDAPPSDKROOT="/opt/AMDAPPSDK-3.0"
#export CPLUS_INCLUDE_PATH="/opt/AMDAPPSDK-3.0/include:$CPLUS_INCLUDE_PATH"

# Classpath for choco
export CLASSPATH="/home/james/Documents/Uni/CPM/exercise2-2019/java/choco-4.10.0/choco-solver-4.10.0.jar:/home/james/Documents/Uni/CPM/exercise2-2019/java/"
export JAVA_HOME="/usr/lib/jvm/default-java/"

export RF4A_DIR="/home/james/Documents/Uni/MSci-Project/RefactorF4Acc/"
export PERL5LIB="$RF4A_DIR:$PERL5LIB"
export PATH="$PATH:$RF4A_DIR/bin"

export PATH="/home/james/Documents/Uni/CPM/minizinc/bin":$PATH
export PATH="/media/linux-ssd/anaconda3/bin:~/.local/bin":$PATH
export PATH="/home/james/Android/Sdk/platform-tools/":$PATH
export PATH="/usr/local/go/bin":$PATH
export PATH="/home/james/go/bin":$PATH
export PATH="/home/james/bin":$PATH

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# use ripgrep by default
export FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden 3>/dev/null'
export FZF_CTRL_T_COMMAND='rg --files --no-ignore-vcs --hidden 2>/dev/null'
