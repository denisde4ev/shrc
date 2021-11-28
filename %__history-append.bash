#!/hint/bash

# STRICTLY FOR BASH (maby zsh idk)

HISTSIZE=500000
HISTFILESIZE=1000000

### https://unix.stackexchange.com/questions/1288/preserve-bash-history-in-multiple-terminal-windows
HISTCONTROL=ignoredups:erasedups # Avoid duplicates


shopt -s autocd # change to named directory
shopt -s cdspell # autocorrects cd misspellings
shopt -s cmdhist # save multi-line commands in history as single line
shopt -s dotglob
shopt -s extglob
shopt -s histappend # do not overwrite history #####
shopt -s expand_aliases # expand aliases


# PROMPT_COMMAND="${PROMPT_COMMAND:+"$PROMPT_COMMAND
# "}history -a;" # After each command, append to the history file and reread it
# PROMPT_COMMAND="(echo 1;history -a;) 2>&-"

PROMPT_COMMAND=

_prompt_command_append() {
	PROMPT_COMMAND="${PROMPT_COMMAND:+"$PROMPT_COMMAND; "}$1"
}

# case ${TERM} in
#   xterm*|rxvt*|Eterm|aterm|kterm|gnome*) PROMPT_COMMAND='printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"' ;;
#   screen*)                               PROMPT_COMMAND='printf "\033_%s@%s:%s\033\\" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"' ;;
# esac

# PROMPT_COMMAND='printf "\033]0;%s\007" "${PWD/#$HOME/\~}"; history -a'
case $TERM in
	# xterm*|rxvt*|Eterm|aterm|kterm|gnome*) PROMPT_COMMAND='printf "\033]0;%s\007"  "'"$(a=\\$ eval echo '"\\${a@P} "')"'${PWD/#$HOME/\~}"' ;;
	xterm*|rxvt*|Eterm|aterm|kterm|gnome*) 
		if [ -n "$SSH_TTY" ]; then
			PROMPT_COMMAND='printf "\033]0;%s\007"  "${USER:-$(id -un)}@${HOSTNAME:-$(hostname)} ${PWD/#$HOME/\~}"'
		else
			PROMPT_COMMAND='printf "\033]0;%s\007"  "$(a=\\\$ eval echo \"\${a@P} \") ${PWD/#$HOME/\~}"'
		fi
	;;
	screen*) PROMPT_COMMAND='printf "\033_%s\033\\"  "'"$(a=\\\$ eval echo \"\${a@P} \")"'${PWD/#$HOME/\~}"' ;;
esac

_prompt_command_append 'history -a'

PROMPT_COMMAND="{ $PROMPT_COMMAND ; } 2>&-" #dont print to console in set -x
# bats_battery_status=$(bats)
# _prompt_command_append 'printf "\033]0;%s\007" "${bats_battery_status}"'




