
# set-x='_set_x'
_set_x() { (
	com=$1; shift
	if compath=$(command -v "$com") && [ -x "$compath" ]; then
		arg "compath" "$@"
		bash -x "$compath" "$@";
	else
		set -x; eval "$com ${@:+"\"\$@\""}"  #"fix
		# $ "set -x; $@"
	fi
) }
