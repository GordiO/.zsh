# Name: zsh Night Sun shell
# Author: Gordio Gordio@ya.ru
# Last modified: 2011-01-01
# Licence: GPL, MIT

HISTFILE="$HOME/.zsh_history" # Файл истории
SAVEHIST=10000              # Размер истории команд (в HISTFILE)
HISTSIZE=$SAVEHIST          # Память текущего сеанса (рекомендуют идентичную SAVEHIST)

## OPTIONS: Настройки
setopt APPEND_HISTORY       # Дополнять файл истории
setopt INCAPPENDHISTORY     # Дополнять историю сразу при выполнении команды
setopt HIST_IGNORE_ALL_DUPS # При добавлении новой строки истории очищаются ее повторения
setopt HIST_IGNORE_SPACE    # Не добавлять историю если первым симколом команды идет пробел
setopt HIST_REDUCE_BLANKS   # Чистить излишние пустые строки
setopt HIST_NO_STORE        # не добавлять в историю `fc -l`
setopt AUTOCD               # Автоматически переходить в директории (без cd)
setopt BRACECCL             # Включить разворот {1-4} или {a-d}
setopt NOCLOBBER            # Не переписывать файл echo > file если он существует. Что бы отменить используем >!
setopt RM_STAR_WAIT         # Что бы предотвратить rm * o вместо rm *.o (как пример)
setopt EQUALS               # Удобные сокращения путей к файлам

## MODULES: Модули
autoload colors && colors       # Раскраска через $fg, $bg etc.

### altPROMPT: Устанавливаем все уровни приглашения
PS1='%(!.%F{red}#%f.%F{green}$%f)%F{yellow}%40<…<%~%f${vcs_info_msg_0_}>'
RPS1='%F{gray}$p_rc%f'
PS2='·  >'
RPS2='%2<…<%i'      # показываем только двузначные номера строк
PS3='·  ·  >'
RPS3='%3<…<%i'      # ... трехзначные ...
PS4='·  ·  ·  >'
RPS4='%4<…<%i'      # ... четырех

# FUNC FOLDER: Директория функций
fpath=($fpath $HOME/.zsh/func)
typeset -U fpath

precmd ()
{
	#setopt NOXTRACE LOCALOPTIONS
	local exitstatus=$?
	[[ $exitstatus -ge 128 ]] && psvar[1]=" $signals[$exitstatus-127]" || psvar[1]=""
	vcs_info
}
setopt PROMPT_SUBST
# Если код выхода с выполняемой программы отличен от 0 тогда справа выводим его.
p_rc="%(?.%T. [%F{red}%?%f%1v%f])"


if [ -f ~/.zsh/env ]
then
	source ~/.zsh/env
fi

# COLORS: Включаем раскраску для файлов
eval `dircolors ~/.dircolors`
# - colorize, since man-db fails to do so
export LESS_TERMCAP_mb=$'\033[01;31m'   # begin blinking
export LESS_TERMCAP_md=$'\033[01;31m'   # begin bold
export LESS_TERMCAP_me=$'\033[0m'       # end mode
export LESS_TERMCAP_se=$'\033[0m'       # end standout-mode
export LESS_TERMCAP_so=$'\033[1;33;40m' # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\033[0m'       # end underline
export LESS_TERMCAP_us=$'\033[1;32m'    # begin underline

# USABILITY: Удобность и повседневность
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias hexedit='hexedit --color'
alias euses='euses --colour'
if [ -f /usr/bin/grc ]; then
	alias ping="grc --colour=auto ping -i 2 -c 5"
	alias traceroute="grc --colour=auto traceroute"
	alias make="grc --colour=auto make"
	alias diff="grc --colour=auto diff"
	alias cvs="grc --colour=auto cvs"
	alias netstat="grc --colour=auto netstat"
fi
alias md='nocorrect mkdir -p'
alias rd='rmdir'
alias ...='../..'           # Родитель родителя =)
alias ....='../../..'       # >_<
alias cd1='cd -'
alias cd2='cd +2'
alias cd3='cd +3'
alias cd4='cd +4'           # дальше левой рукой тянуться тяжеловато :P
alias ll='ls -lh'           # вывog в gлuннoм фopмaтe
alias la='ls -Ah'           # вывog всех файлов, включая dot-фaйлы, kpoмe . u ..
alias lsa='ls -ldh .*'      # вывog тoльko dot-фaйлoв
alias lsd='ls -ldh *(-/DN)' # вывод только каталогов
alias _='sudo'              # супер пользователь
alias __='sudo -s'         # супер пользователь (Шелл)

### GLOBAL ALIAS's: нями =)
alias -g  CA='|& cat -A'
alias -g  CL='| wc -l'
alias -g   C='***/*.([chly]|[ch]pp|[ch]xx|C)'
alias -g HEX='| xxd -g 1'
alias -g   G='| grep'
alias -g   S='| sed'
alias -g   H='| head'
alias -g   T='| tail'
alias -g IKU='| iconv -cf koi8r  -t utf8'
alias -g IKW='| iconv -cf koi8r  -t cp1251'
alias -g IUK='| iconv -cf utf8   -t koi8r'
alias -g IUW='| iconv -cf utf8   -t cp1251'
alias -g IWK='| iconv -cf cp1251 -t koi8r'
alias -g IWU='| iconv -cf cp1251 -t utf8'
alias -g   L='| less'
alias -g  LE='|& less'
alias -g  PD='| patch -p1 --dry-run'
alias -g  WP='| wgetpaste'
# Подсветка ошибок, например: find /etc HE GI zsh
alias -g  HE='2>>( sed -ue "s/.*/$fg_bold[red]&$reset_color/" 1>&2 )'

# Или можно подсвечивать все время
#exec 2>>(while read line; do
#    print '\e[91m'${(q)line}'\e[0m' > /dev/tty
#    print -n $'\0'
#done &)


if [ -f ~/.zsh/alias ]; then
	source ~/.zsh/alias
fi

alias -s {html,htm}=$BROWSER
alias -s {avi,mpeg,mpg,mov,wmv,flv,vob,ac3,mkv,mov,mp4,3gp,divx,xvid}=$VIDEO_PLAYER
alias -s {png,bmp,gif,jpg,jpeg,xml}=$IMG_BROWSER
alias -s {txt,c,h,cpp,php,conf,ini}=$EDITOR
alias -s mht='opera'

### KEYBINDINGS: Установка нормального поведения клавиш Delete, Home, End и т.д.:
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

bindkey "^R" history-incremental-search-backward
bindkey "^El" _most_recent_file     # добавить последний измененный файл
bindkey "^E" expand-cmd-path        # делаем абсолютный путь к набираемой команде

# вкусняшка: сама подбирает команду =)
#autoload -U predict-on
#zle -N predict-on
#zle -N predict-off
#bindkey "^Z" predict-on     # <Control>+z что бы включить
#bindkey "^X^Z" predict-off  # <Control>+x <Control>+z что бы выключить

### LIMITS: Лимиты :P
limit stack 8192    # Лимит объёма памяти, выделенной под стек, дабы не переполнялся
limit core 0        # Выключаем запись дампов упавших в корку программ
umask 022           # Установка атрибутов доступа создаваемых файлов

autoload -U compinit promptinit
compinit

# TODO Это очень очень крутая часть zsh. Слишком тяжела для моего маленького мозга.
# Поэтому крутой автокомплит я буду делать по возможности.

# Использовать кеш для автодополнения.
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path ~/.zsh/cache/$HOST

# Раскрашиваем цвета
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# Исправлять ввод только если одна ошибка на 6 символов
zstyle -e ':completion:*:approximate:*' max-errors \
		'reply=( $(( ($#PREFIX+$#SUFFIX)/6 )) numeric )'


# Чтобы видеть все процессы для kill или killall.
# При нажатии Tab автоматически добавится имя процесса
zstyle ':completion:*:processes' command 'ps ax -o pid,user,s,nice,args | sed "/ps/d"'
#zstyle ':completion:*:processes' sort false
zstyle ':completion:*:processes-names' command 'ps xho command'
zstyle ':completion:*:*:kill:*:processes' command 'ps -u $USER -o pid,user,cmd'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always
zstyle ':completion:*:cd:*' ignore-parents parent pwd
zstyle -e ':completion:*:tsocks:*' command-path 'reply=($path)'
zstyle -e ':completion:*:sudo:*' command-path 'reply=($path /usr/local/sbin /sbin /usr/sbin)'

autoload -Uz vcs_info # Красоты с SVN, GIT, etc...
# включаем только git svn svk cvs. Возможные VCS можно посмотреть командой vcs_info_printsys
#zstyle ':vcs_info:*' enable svn git cvs hg
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' get-revision      true
zstyle ':vcs_info:*' disable-patterns "$HOME(/bin|/Videos|/Music)"
zstyle ':vcs_info:(svn|bzr):*'  branchformat '%b%F{1}:%F{3}%r'
zstyle ':vcs_info:*' stagedstr "%F{red}•"
zstyle ':vcs_info:*' unstagedstr "%F{yellow}•"
#zstyle ':vcs_info:*' actionformats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f'
#zstyle ':vcs_info:*' formats '%F{green}%s%F{white}:%F{yellow}%b%F{red}%c%u%F{default}'
zstyle ':vcs_info:*' actionformats ':%F{green}%b%u%c%F{default}'
zstyle ':vcs_info:*' formats ':%F{green}%16<…<%b%u%c%F{default}'
setopt PROMPT_SUBST


zstyle ':completion:*' menu select=long-list select=0
zstyle ':completion:*' old-menu true
zstyle ':completion:*' original true
zstyle ':completion:*' substitute 1
zstyle ':completion:*' use-compctl true
zstyle ':completion:*' verbose true
zstyle ':completion:*' word true
# Uncomment next line if need case-sencitivitie
#zstyle ':completion:*' matcher-list '' 'm:{a-z}={a-z}' '+ l:|=* r:|=*'
# or don't need case-sen
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' '+ l:|=* r:|=*'
compctl -C -c + -K compctl_rehash + -c

# ignore completion functions (until the _ignored completer)
zstyle ':completion:*:functions' ignored-patterns '_*'
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' list-prompt %SСейчас на %p. Нажми TAB, чтобы листать далее или следующий символ для подстановки%s
zstyle ':completion:*' list-suffixes true
#zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z} r:|[._-]=** r:|=**' 'm:{a-z}={A-Z} m:{a-zA-Z}={A-Za-z} r:|[._-]=** r:|=** l:|=*' 'm:{a-zA-Z}={A-Za-z} r:|[._-]=** r:|=** l:|=*' 'm:{a-zA-Z}={A-Za-z} r:|[._-]=** r:|=** l:|=*'
#zstyle ':completion:*' menu select=1
zstyle ':completion:*' preserve-prefix '//[^/]##/'
zstyle ':completion:*' select-prompt %SСкроллинг активен. Текущее выделение на: %p%s
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' use-compctl true

# Дополняем алиасы mutt'а
if [[ -f ~/.mutt/baliases ]]; then
	zstyle ':completion:*:mutt:*' ignored-patterns '*'
	zstyle ':completion:*:mutt:*' users \
	${${${(f)"$(<~/.mutt/baliases)"}#alias[[:space:]]}%%[[:space:]]*}
fi

# Как настроить автодополнение в zsh для ssh хостов взятых из ~/.ssh/known_hosts
#ssh_hosts=($hosts ${${${(f)"$(&lt;$HOME/.ssh/known_hosts)"}%%\ *}%%,*})
# automatically remove duplicates from these arrays
typeset -U ssh_hosts
zstyle ':completion:*:hosts' hosts $ssh_hosts
zstyle ':completion:*:(ssh|scp|sftp):*' tag-order '! users' #не добавлять юзера

zstyle ':completion:*:functions' ignored-patterns '_*'
