#! /hint/bash

# STRICTLY FOR BASH (maby zsh idk)

HISTSIZE=500000
HISTFILESIZE=1000000

#### https://unix.stackexchange.com/questions/1288/preserve-bash-history-in-multiple-terminal-windows
#HISTCONTROL=ignoredups:erasedups # Avoid duplicates
HISTCONTROL=ignoreboth:erasedups


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

case ${NEW_LINE:+x} in '') return; esac

_prompt_command_append() {
	PROMPT_COMMAND="${PROMPT_COMMAND:+"$PROMPT_COMMAND${NEW_LINE:-$'\n'}"}$1"
}

# case ${TERM} in
#   xterm*|rxvt*|Eterm|aterm|kterm|gnome*) PROMPT_COMMAND='printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"' ;;
#   screen*)                               PROMPT_COMMAND='printf "\033_%s@%s:%s\033\\" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"' ;;
# esac

# PROMPT_COMMAND='printf "\033]0;%s\007" "${PWD/#$HOME/\~}"; history -a'
case $TERM in
	# xterm*|rxvt*|Eterm|aterm|kterm|gnome*) PROMPT_COMMAND='printf "\033]0;%s\007"  "'"$(a=\\$ eval echo '"\\${a@P} "')"'${PWD/#$HOME/\~}"' ;;
	xterm*|rxvt*|Eterm|aterm|kterm|gnome*)
		case ${SSH_TTY+x} in
			x) PROMPT_COMMAND='printf "\033]0;%s\007"  "${USER:-$(id -un)}@${HOSTNAME:-$(hostname)} ${PWD/#$HOME/\~}"';;
			*) PROMPT_COMMAND='printf "\033]0;%s\007"  "$(a=\\\$ eval echo \"\${a@P} \") ${PWD/#$HOME/\~}"';;
		esac
	;;
	screen*) PROMPT_COMMAND='printf "\033_%s\033\\"  "'"$(a=\\\$ eval echo \"\${a@P} \")"'${PWD/#$HOME/\~}"' ;;
esac

_prompt_command_append 'history -a'
_prompt_command_append 'history_current_command >> ~/.local/share/bash/longhistory'

PROMPT_COMMAND="{$NEW_LINE$PROMPT_COMMAND$NEW_LINE} 2>&-" # hidde PROMPT_COMMAND debug from xtrace(set -x)
# bats_battery_status=$(bats)
# _prompt_command_append 'printf "\033]0;%s\007" "${bats_battery_status}"'

