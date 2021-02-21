#case insensitive globing 
setopt NO_CASE_GLOB
## Completion
##############################################################################
# case insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# for cd, don't try username completions (~polti)
zstyle ':completion:*:cd:*' tag-order local-directories path-directories
#
# Completion in rm, mv, cp
zstyle ':completion:*:rm:*' ignore-line yes
zstyle ':completion:*:mv:*' ignore-line yes
zstyle ':completion:*:cp:*' ignore-line yes
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'

# Completion selection by menu for kill
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'

# Menu select
zstyle ':completion:*' menu selectse up auto completion 
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select
setopt COMPLETE_ALIASES

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

#You can revert the options for the current shell to the default settings with the following command:
    ##emulate -LR zsh

# Bind Key
##############################################################################
# Input control
bindkey '^B' backward-word    # Ctrl + LEFT
bindkey '^W' forward-word     # Ctrl + RIGHT
bindkey '\e[1~' beginning-of-line  # Debut
bindkey '\e[4~' end-of-line        # fin
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward
#ALIAS
#
#
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
setopt autocd                      # Typing cd every time is boring
setopt complete_aliases
#PLUGINS
source $HOME/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

source /$HOME/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
export PATH=$PATH:$HOME/Library/Python/3.9/bin

