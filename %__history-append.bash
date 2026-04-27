#! /hint/bash

# STRICTLY FOR BASH (maby zsh idk)

HISTSIZE=500000
HISTFILESIZE=1000000

#### https://unix.stackexchange.com/questions/1288/preserve-bash-history-in-multiple-terminal-windows
#HISTCONTROL=ignoredups:erasedups # Avoid duplicates
HISTCONTROL=ignoreboth:erasedups


HISTIGNORE="rm*"


#[[ $DISPLAY ]] && shopt -s checkwinsize # gives vars $COLUMNS $LINES
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


## working example of window title:
#PROMPT_STRING='\[\e]0;TITLE\a\]'
#PROMPT_COMMAND='printf "\033]0;%s\007" TITLE'




#TITLE_FORMAT='pid=$$ ?=$? pwd$PWD d$BASH_COMMAND'

unset history_current_command_espanded
_Ief8Ga2z__ondebug_set_title() {
	case ${#FUNCNAME[@]}:${BASH_SUBSHELL} in 1:0) ;; *) return; esac
	case $BASH_COMMAND in "trap "*" DEBUG") return;  esac

	history_current_command_espanded=$BASH_COMMAND

	_Ief8Ga2z__set_title
}




# PROMPT_COMMAND='printf "\033]0;%s\007" "${PWD/#$HOME/\~}"; history -a'
case $TERM in
	# xterm*|rxvt*|Eterm|aterm|kterm|gnome*) PROMPT_COMMAND='printf "\033]0;%s\007"  "'"$(a=\\$ eval echo '"\\${a@P} "')"'${PWD/#$HOME/\~}"' ;;
	xterm*|rxvt*|Eterm|aterm|kterm|gnome*)
		_Ief8Ga2z__set_title() {
			printf '\033]0;%s\007' "${TITLE_FORMAT@P}"
		}
		case ${SSH_TTY+x} in
			#x) TITLE_FORMAT='[SSH_TTY=$SSH_TTY] ${USER:-$(id -un)}@${HOSTNAME:-$(hostname)} \w';;
			x) TITLE_FORMAT='[SSH_TTY=$SSH_TTY] \u@\H \w';;
			*) TITLE_FORMAT='\w \$ ${history_current_command_espanded+" { $history_current_command_espanded }"} ($$)';;
		esac
	;;
	screen*)
		TITLE_FORMAT='\w \$ ($$)'

		_Ief8Ga2z__set_title() {
			printf '\033_%s\033' "${TITLE_FORMAT@P}" # NEVER EVER HAVE BEEN TESTED
		}
	;;
esac










PROMPT_COMMAND_FUNCTION() {
	history -a
	eval 'history_current_command; puts "### $history_current_command_espanded"' >> ~/.local/share/bash/longhistory

	trap '{ _Ief8Ga2z__ondebug_set_title; } 2>&-' DEBUG
	unset history_current_command history_current_command_espanded
	
	_Ief8Ga2z__set_title # when command done
}
alias longhistory='(cat ~/.local/share/bash/longhistory)'

PROMPT_COMMAND="trap - DEBUG; PROMPT_COMMAND_FUNCTION"


_Ief8Ga2z__set_title # init


PROMPT_COMMAND="{$NEW_LINE$PROMPT_COMMAND$NEW_LINE} 2>&-" # hidde PROMPT_COMMAND debug from xtrace(set -x)
# bats_battery_status=$(bats)
# _prompt_command_append 'printf "\033]0;%s\007" "${bats_battery_status}"'

