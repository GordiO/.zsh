# Name: zsh Night Sun shell
# Author: Gordio Gordio@ya.ru
# Last modified: 2011-01-01
# Licence: GPL, MIT

HISTFILE="$ZDOTDIR/.zhistory" # Файл истории
SAVEHIST=10000              # Размер истории команд (в HISTFILE)
HISTSIZE=10000

## OPTIONS
# http://zsh.sourceforge.net/Doc/Release/Options-Index.html
setopt APPEND_HISTORY       # Append history file
setopt INCAPPENDHISTORY     # Append history file after command execution
setopt HIST_IGNORE_ALL_DUPS # Keep history commands unique
setopt HIST_IGNORE_SPACE    # Don't save command to history if first symbol space
setopt HIST_REDUCE_BLANKS   # Delete blank lines
setopt HIST_NO_STORE        # Don't add to history `fc -l`
setopt AUTOCD               # Automatic cd to directories exmpl: /root + Enter
setopt BRACECCL             # Включить разворот {1-4} или {a-d}
setopt NOCLOBBER            # Не переписывать файл echo > file если он существует. Что бы отменить используем >!
setopt RM_STAR_WAIT         # Что бы предотвратить rm * o вместо rm *.o (как пример)
setopt EQUALS               # Удобные сокращения путей к файлам


### altPROMPT: Устанавливаем все уровни приглашения
PS1='%F{magenta}%m%f@%(!.%F{red}%B.%F{green})%n%b%f %F{yellow}%40<…<%~%f${vcs_info_msg_0_}>'
RPS1='%F{gray}$p_rc%f'
PS2='·  >'
RPS2='%2<…<%i'      # показываем только двузначные номера строк
PS3='·  ·  >'
RPS3='%3<…<%i'      # ... трехзначные ...


# FUNC FOLDER
if [ $UID != 0 ]; then
	fpath=($fpath $ZDOTDIR/func.d)
	typeset -U fpath
fi


## MORE
# Show branches for VCS in terminal PS
autoload -Uz vcs_info
# Enabled for ... For supported list: `vcs_info_printsys`
#zstyle ':vcs_info:*' enable svn git cvs hg
zstyle ':vcs_info:(svn|bzr):*' branchformat '%b%F{1}:%F{3}%r'
zstyle ':vcs_info:*' check-for-changes true
#zstyle ':vcs_info:*' get-revision      true
zstyle ':vcs_info:*' stagedstr "%F{red}•"
zstyle ':vcs_info:*' unstagedstr "%F{yellow}•"
zstyle ':vcs_info:*' actionformats ':%F{green}%b%u%c%F{default}'
zstyle ':vcs_info:*' formats ':%F{green}%20<…<%b%u%c%F{default}'
#zstyle ':vcs_info:*' disable-patterns "$HOME(/example_usage)"
setopt PROMPT_SUBST


precmd ()
{
	#setopt NOXTRACE LOCALOPTIONS
	local exitstatus=$?
	[[ $exitstatus -ge 128 ]] && psvar[1]=" $signals[$exitstatus-127]" || psvar[1]=""
	vcs_info
}
setopt PROMPT_SUBST
# Если код выхода с выполняемой программы отличен от 0 тогда справа выводим его.
p_rc="%(?.. [%F{red}%?%f%1v%f])"


## ALIASES
alias md='nocorrect mkdir -p'

alias ..='cd ..'
alias -g ...='../..'
alias -g ....='../../..'
alias cd1='cd -'
alias cd2='cd +2'
alias cd3='cd +3'
alias ll='ls -lh'            # вывog в gлuннoм фopмaтe
alias la='ls -Ah'            # вывog всех файлов, включая dot-фaйлы, kpoмe . u ..
alias lsd='ls -ldh *(-/DN)'  # Show only directories
alias _='sudo'               # Exec as root
alias __='sudo -s'           # Run root shell

alias -g  CL='| wc -l'
alias -g   G='| grep'
alias -g   S='| sed'
alias -g   H='| head'
alias -g   T='| tail'
alias -g   L='| less'


# Highlight errors
# Usage: find /etc HE G zsh
alias -g  HE='2>>( sed -ue "s/.*/$fg_bold[red]&$reset_color/" 1>&2 )'


## KEYBINDINGS
bindkey "^R" history-incremental-search-backward  # Search in History
bindkey "^El" _most_recent_file  # Add last edited file (Activate: atime)
bindkey "^E" expand-cmd-path     # делаем абсолютный путь к набираемой команде

case $TERM in
	xterm)
		bindkey '\eOH' beginning-of-line
		bindkey '\eOF' end-of-line
		bindkey '\e[2~' overwrite-mode
		bindkey '\e[5~' beginning-of-buffer-or-history
		bindkey '\e[6~' end-of-buffer-or-history
		;;
	*)
		bindkey '\e[1~' beginning-of-line
		bindkey '\e[3~' delete-char
		bindkey '\e[4~' end-of-line
		bindkey '\177' backward-delete-char
		bindkey '\e[2~' overwrite-mode

		bindkey "\e[7~" beginning-of-line
		bindkey "\e[H" beginning-of-line
		#bindkey "\e[2~" transpose-words
		bindkey "\e[8~" end-of-line
		bindkey "\e[F" end-of-line
		;;
esac


## AUTOCOMPLETION
autoload -U compinit promptinit
compinit

# General
zstyle ':completion:*' menu select=long-list select=0
zstyle ':completion:*' old-menu true
zstyle ':completion:*' original true
zstyle ':completion:*' substitute 1
zstyle ':completion:*' use-compctl true
zstyle ':completion:*' verbose true
zstyle ':completion:*' word true
# Uncomment next line if need case-sensitivity
#zstyle ':completion:*' matcher-list '' 'm:{a-z}={a-z}' '+ l:|=* r:|=*'
# or don't need case-sensitivity
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' '+ l:|=* r:|=*'

# Use cache: Использовать кеш для автодополнения.
zstyle ':completion:*:default' use-cache 1
# Use colors: Раскрашиваем цвета
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# ignore completion functions (until the _ignored completer)
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' preserve-prefix '//[^/]##/'
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' use-compctl true

# Fix type: Исправлять ввод только если одна ошибка на 6 символов
zstyle -e ':completion:*:approximate:*' max-errors \
		'reply=( $(( ($#PREFIX+$#SUFFIX)/6 )) numeric )'


zstyle ':completion:*:processes' command 'ps ax -o pid,user,s,nice,args | sed "/ps/d"'
#zstyle ':completion:*:processes' sort false
zstyle ':completion:*:processes-names' command 'ps xho command'
zstyle ':completion:*:*:kill:*:processes' command 'ps -u $USER -o pid,user,cmd'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always

# Directories
zstyle ':completion:*:cd:*' ignore-parents parent pwd  # Ignore ../

## USER SETTINGS
[ -f ~/.zshrc ] && . ~/.zshrc
