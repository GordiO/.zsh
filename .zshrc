# Name: YAZ - Yet Another ZSH
# Author: Gordio admin@gordio.pp.ua
# Last modified: 2014-05-29
# Licence: GPL, MIT

HISTFILE="$HOME/.zsh_history" # Файл истории
SAVEHIST=10000              # Размер истории команд (в HISTFILE)
HISTSIZE=1000

## OPTIONS
# http://zsh.sourceforge.net/Doc/Release/Options-Index.html
setopt APPEND_HISTORY # Append history file
setopt INCAPPENDHISTORY # Append history file after command execution
setopt HIST_IGNORE_ALL_DUPS # Keep history commands unique
setopt HIST_IGNORE_SPACE # Don't save command to history if first symbol space
setopt HIST_REDUCE_BLANKS # Delete blank lines
setopt HIST_NO_STORE # Don't add to history `fc -l`
setopt AUTOCD # Automatic cd to directories exmpl: /root + Enter
setopt BRACECCL # Включить разворот {1-4} или {a-d}
setopt NOCLOBBER # Не переписывать файл echo > file если он существует. Что бы отменить используем >!
#setopt RM_STAR_WAIT # Что бы предотвратить rm * o вместо rm *.o (как пример)
setopt EQUALS # Удобные сокращения путей к файлам
setopt PROMPT_SUBST # Allow functions in prompt

#Auto Escape URLS
autoload -U url-quote-magic
zle -N self-insert url-quote-magic

# KEYBINDINGS
bindkey "^R" history-incremental-search-backward # Search in History
bindkey "^E" _most_recent_file # Add last edited file (Activate: atime)
bindkey "^El" expand-cmd-path # expand absolute command path


# PROMPT
# One line prompt
if [ -z ${ZSH_MULTILINE} ]; then
	export PS1='%(!.%F{red}%B.%F{green})%n%b%f@%F{magenta}%m%f %F{yellow}%40<…<%~%f${vcs_info_msg_0_}>'
else
	PS1_USER="%(!.%F{red}%B.%F{green})%n%b%f"
	PS1_HOST="%F{magenta}%m%f"
	PS1_PATH="%F{yellow}%~%f"
	export PS1=$'${PS1_HOST}@${PS1_USER} ${PS1_PATH}${vcs_info_msg_0_}\n%(!.%F{red}%B.%F{white})%B❱%b%f '
fi

export RPS1='%F{gray}$p_rc%f'


# ALIASES
alias md='nocorrect mkdir -p'

alias ..='cd ..'
alias -g ...='../..'
alias -g ....='../../..'
alias cd1='cd -'
alias cd2='cd +2'
alias cd3='cd +3'
alias ll='ls -lh'
alias _='sudo'               # Exec as root
alias __='sudo -s'           # Run root shell

alias -g G='| grep'
alias -g S='| sed'
alias -g H='| head'
alias -g T='| tail'
alias -g L='| less'


# CONF: Add functions folder (completions etc...)
fpath=($ZDOTDIR/func.d $fpath)
typeset -U fpath

# CONF: Completion
zstyle ':completion:*' menu select=long-list select=0
zstyle ':completion:*' verbose true
# Uncomment next line if need case-sensitivity
#zstyle ':completion:*' matcher-list '' 'm:{a-z}={a-z}' '+ l:|=* r:|=*'
# or don't need case-sensitivity
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' '+ l:|=* r:|=*'

# CONF: User settings
[ -f ~/.zshrc ] && . ~/.zshrc


# INIT: Prepare default config
if [ ! $plugins ]; then
	plugins=(vcs_prompt)
fi

# INIT: Load all defined plugins
for plugin in $plugins; do
	autoload -Uz $plugin && $plugin
done

# INIT: Completions
autoload -Uz compinit
if [[ -n ${ZDOTDIR:-${HOME}}/$ZSH_COMPDUMP(#qN.mh+24) ]]; then
	compinit -d $ZSH_COMPDUMP;
else
	compinit -C;
fi;
