#case insensitive globing 
setopt NO_CASE_GLOB
export XDG_CONFIG_HOME="${HOME}/.config"
ZSH_DIR="${XDG_CONFIG_HOME}/zsh"
# Autoload functions {{{
fpath=(${ZSH_DIR}/functions $fpath)
autoload -U ${ZSH_DIR}/functions/*(:t)
# }}}
## Completion {{{

# for cd, don't try username completions (~polti)
zstyle ':completion:*:cd:*' tag-order local-directories path-directories
#
# Menu select
zstyle ':completion:*' menu selectse up auto completion 
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select
setopt COMPLETE_ALIASES
# Completion in rm, mv, cp
zstyle ':completion:*:rm:*' ignore-line yes
zstyle ':completion:*:mv:*' ignore-line yes
zstyle ':completion:*:cp:*' ignore-line yes
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'

# Completion selection by menu for kill
# zstyle ':completion:*:*:kill:*' menu yes select
# zstyle ':completion:*:kill:*' force-list always
# zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
# zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
# case insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# }}}
# Colors {{{
# Font color
# 16 color terminals
fg_black=%F{000}
fg_red=%F{001}
fg_green=%F{002}
fg_lbrown=%F{003}
fg_blue=%F{004}
fg_dbrown=%F{005}
fg_lblue=%F{006}
fg_lgrey=%F{007}
fg_grey=%F{008}
fg_lred=%F{009}
fg_lgreen=%F{010}
fg_yellow=%F{011}
fg_dblue=%F{012}
fg_lbrown=%F{013}
fg_llblue=%F{014}
fg_white=%F{015}
fg_black2=%F{016}
# 256 color bonus
fg_orange=%F{208}
fg_purple=%F{164}
fg_pink=%F{212}
fg_2grey=%F{248}

# Attributes
at_normal=%{$'\e[0m'%}
at_bold=%{$'\e[1m'%}
at_italics=%{$'\e[3m'%}
at_underl=%{$'\e[4m'%}
at_blink=%{$'\e[5m'%}
at_outline=%{$'\e[6m'%}
at_reverse=%{$'\e[7m'%}
at_nondisp=%{$'\e[8m'%}
at_strike=%{$'\e[9m'%}
at_boldoff=%{$'\e[22m'%}
at_italicsoff=%{$'\e[23m'%}
at_underloff=%{$'\e[24m'%}
at_blinkoff=%{$'\e[25m'%}
at_reverseoff=%{$'\e[27m'%}
at_strikeoff=%{$'\e[29m'%}

# ls colors
autoload colors; colors;
export LSCOLORS="Gxfxcxdxbxegedabagacad"

# Enable ls colors
if [ "$DISABLE_LS_COLORS" != "true" ]
then
    # Find the option for using colors in ls, depending on the version: Linux or BSD
    if [[ "$(uname -s)" == "NetBSD" ]]
    then
        # On NetBSD, test if "gls" (GNU ls) is installed (this one supports colors)
        # otherwise, leave ls as is, because NetBSD's ls doesn't support -G
        gls --color -d . &>/dev/null 2>&1 && alias ls='gls --color=tty'
    elif [[ "$(uname -s)" == "OpenBSD" ]]
    then
        # On OpenBSD, test if "colorls" is installed (this one supports colors)
        # otherwise, leave ls as is, because OpenBSD's ls doesn't support -G
        colorls -G -d . &>/dev/null 2>&1 && alias ls='colorls -G'
    else
        ls --color -d . &>/dev/null 2>&1 && alias ls='ls --color=tty' || alias ls='ls -G'
    fi
fi
# }}}
# Prompt {{{
setopt prompt_percent
setopt prompt_subst     # allow function for prompt
autoload -U promptinit

# Enable auto-execution of functions.
typeset -ga preexec_functions
typeset -ga precmd_functions
typeset -ga chpwd_functions

# Append git functions needed for prompt.
precmd_functions+='update_current_git_vars'
chpwd_functions+='update_current_git_vars'

# Reset prompt and right prompt
export PROMPT
export RPROMPT

# The prompt
function setprompt()
{
    local -a infoline llines rlines
    local i_width i_filler filler

    # Introduce the prompt with some design.
    infoline=( "%{$fg[cyan]%}┏━┫" )

    # User informations.
    infoline+=( "%{$fg[green]%}%n%{$fg[cyan]%}@" )

    if [ -n "$SSH_CLIENT" ]
    then
        infoline+=( "%{$fg[red]%}%m" )

    else
        infoline+=( "%{$fg[blue]%}%m" )
    fi

    # Display time.
    infoline+=( "%{$fg[cyan]%}┣━┫%{$fg[default]%}%T" )

    # Display the numbers of jobs suspended or running in background.
    infoline+=( "%(1j.%{$fg[cyan]%}┣━┫%{$fg[yellow]%}%j.)" )

    # Display git info.
    infoline+=( "$(prompt_git_info)" )
    infoline+=( "%{$fg[cyan]%}┃" )

    # Append the different parts of the upper line of the prompt.
    llines=${(j::)infoline}

    # Finish the design of the prompt.
    # Display a green arrow that turns red if the return code of the last
    # function is different of zero.
    llines+=( "%{$fg[cyan]%}┗━%(?:%{$fg[green]%}:%{$fg[red]%})>%{$fg[default]%} ")
    rlines="%{$fg[yellow]%}~/ %{$fg[default]%} "

    PROMPT=${(F)llines}
    RPROMPT=${(F)rlines}
}

precmd_functions+='setprompt'

# }}}

#set history save beyond session
HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history
SAVEHIST=5000
HISTSIZE=2000
# expire duplicates first
setopt HIST_EXPIRE_DUPS_FIRST 
# do not store duplications
setopt HIST_IGNORE_DUPS
#ignore duplicates when searching
setopt HIST_FIND_NO_DUPS
# removes blank lines from history
setopt HIST_REDUCE_BLANKS

setopt autocd                      # Typing cd every time is boring
setopt complete_aliases
#You can revert the options for the current shell to the default settings with the following command:
    ##emulate -LR zsh

# Bind Key {{{
# Input control
bindkey '^B' backward-word    # Ctrl + LEFT
bindkey '^W' forward-word     # Ctrl + RIGHT
bindkey '\e[1~' beginning-of-line  # Debut
bindkey '\e[4~' end-of-line        # fin
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward
# bindkey '^K' history-substring-search-up
# bindkey '^J' history-substring-search-down
# }}}


## Aliases {{{
alias icloud='cd $HOME/Library/Mobile\ Documents/com~apple~CloudDocs' 
alias configfolder='cd $HOME/.config' 
alias la='ls -aG'                   # Shorcut
alias ls='ls -G'                   # Shorcut
alias meteo='curl http://wttr.in'

# Maiia specific aliases {{{

alias gcf='git checkout feat-pro; git pull origin feat-pro; yarn'
alias gfa='git fetch --all'


# }}}



# Global aliases {{{
# (expand whatever their position)
# e.g. find . E L
alias -g G='| grep'
alias -g L='| less -R'
alias -g H='| head'
alias -g S='| sort'
alias -g T='| tail'
# }}}

# Force colors!!!
alias diff='colordiff'
alias less='less -R'
alias grep='grep --colour'
alias tree='tree -C'

# }}}

    # Autolaunch aliases {{{
    # Vim
    alias -s c='vim'
    alias -s h='vim'
    alias -s o='vim'
    alias -s md='vim'
    alias -s cpp='vim'
    alias -s rs='vim'
    alias -s hpp='vim'
    alias -s vim='vim'
    alias -s mk='vim'
    alias -s txt='vim'
    alias -s md='vim'
    alias -s mkd='vim'
    alias -s markdown='vim'
    alias -s lua='vim'
    alias -s java='vim'
    alias -s aidl='vim'
    alias -s tex='vim'
    alias -s xml='vim'
    alias -s iadl='vim'
    alias -s scala='vim'
    alias -s php='vim'
    alias -s ld='vim'
    alias -s d='vim'
    alias -s yml='vim'
    alias -s in='vim'
    alias -s json='vim'

    # other auto launches
    alias -s mkv='vlc'
    alias -s pdf='evince'
    alias -s odt='lowriter'
    alias -s odp='loimpress'
    alias -s ods='localc'
    alias -s xls='localc'
    alias -s rb='ruby'
    alias -s html='firefox'

    # }}}
#PLUGINS {{{
source $HOME/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source /$HOME/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# source /usr/local/share/zsh-history-substring-search/zsh-history-substring-search.zsh

# requires bat to work
export MANPAGER="sh -c 'col -bx | bat -l man -p'" 

#Autojump
[ -f $(brew --prefix)/etc/profile.d/autojump.sh ] && . $(brew --prefix)/etc/profile.d/autojump.sh
export PATH=$PATH:$HOME/Library/Python/3.9/bin

#FZF ** autocomplete
if command -v fzf &>/dev/null; then
  # Auto-completion
  [[ $- == *i* ]] &&
    source "/usr/local/opt/fzf/shell/completion.zsh" 2> /dev/null

  # Key bindings
  source "/usr/local/opt/fzf/shell/key-bindings.zsh"
fi

# }}}
