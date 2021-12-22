#!/ /hint/bash

command_not_found_handle() {
	: ::: command_not_found_handle "$@" ::: :
	# '2>/dev/null' to be quiet on xtrace shell

	local i && \
	local com && \
	local compath && \

	case $1 in
	which)
		i=$(command -v -- "$2") && \
		case $i in */*) echo-1l "$i"; return; esac
		;;
	*"#")
		i=$(history_current_command "$1") && {
			i=${i#" "}
			i=${i#"#"}
			com=${1%"#"}
			## NOOO: try to parse most aliases: # case $i in  *[!"~\!$^&*()=+:;[]{}\"',<.>/?"]*)
			compath=$(command -v "$com") && \
			case $compath in
				*/*) "$com" "$i";;
				*) eval "$com"' "$i"';;
			esac
			return
		}
		;;
	-[A-Z]*)
		case $1 in
			-*[!A-Za-z]*) ;; # must have only letters
			*) trizen "$@"; return;;
		esac
	esac


	printf %s\\n "${0##*/}: $1: command not found" >&2
	return 127

}
