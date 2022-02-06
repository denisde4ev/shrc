
# set-x='_set_x'
_set_x() { (
	case $1 in .)
		shift
		SH_SOURCE=$1
		shift
		set -x;
		. "$SH_SOURCE"
		exit
	esac

	com=$1; shift
	if compath=$(command -v "$com") && [ -x "$compath" ]; then
		arg "compath" "$@"
		# when compath is is real path and it is executable
		# then run it in separate shell (assuming path is shell script) to have xtrace 
		"${SHELL-bash}" -x "$compath" "$@";
	else
		set -x; eval "$com ${@:+"\"\$@\""}"
		# $ "set -x; $@"
	fi
) }
