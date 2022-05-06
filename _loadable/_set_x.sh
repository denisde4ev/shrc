#! /hint/sh

# alis set-x='_set_x'
_set_x() { (
	case $1 in ".")
		shift
		i
		i=$1; shift
		set -x
		. "$i"
		set +x
		exit
	esac

	com=$1; shift
	if compath=$(command -v -- "$com") && [ -x "$compath" ]; then
		eval 'arg "compath" "$@"'
		# when compath is is real path and it is executable
		# then run it in separate shell (assuming path is shell script) to have xtrace 
		"${SHELL-bash}" -x "$compath" "$@";
	else
		set -x
		# dont: $ "set -x; $@", reason: what if the command/fn/alias is only in the current shell
		eval " $com ${@:+"\"\$@\""}" # todo find a way to quote this?
		set +x
		exit
	fi
) }
