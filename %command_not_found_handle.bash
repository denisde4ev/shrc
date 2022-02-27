#! /hint/bash

command_not_found_handle() {
	: ::: command_not_found_handle "$@" ::: :
	# '2>/dev/null' to be quiet on xtrace shell

	case $1 in
	which)
		i;local i
		i=$(command -v -- "$2") && \
		case $i in */*) puts "$i"; I; return; esac
		I
		;;
	*"#")
		i;local i
		i=$(history_current_command "$1") && {
			i=${i#" "}
			i=${i#"#"}
			local com compath
			com=${1%"#"}
			## NOOO: try to parse most aliases: # case $i in  *[!"~\!$^&*()=+:;[]{}\"',<.>/?"]*)
			compath=$(command -v "$com") && \
			case $compath in
				*/*) "$com" "$i";;
				*) eval "$com"' "$i"';;
			esac
			I
			return
		}
		I
		;;
	-[A-Z]*)
		case $1 in
			-*[!A-Za-z]*) ;; # must have only letters
			*) trizen "$@"; return;;
		esac
		;;
	[a-zA-Z0-9]*.)
		i;local i
		i=${1%.};
		YN_confirm n "Run '$i${*#"$i."}' and exit?" && {
			shift
			exec "$i" "$@" # NOTE: this won't exit the main shell, reason: in bash command_not_found_handle is in subshell
			I
			return
		}
		I
		;;
	esac


	printf %s\\n "${0##*/}: $1: command not found" >&2
	return 127

}
