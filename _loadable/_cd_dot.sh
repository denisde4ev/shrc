
_cd_dot() { # alias cd.
	case $# in
		0) cd -P -- .;;
		*) cd -- "$(readlink -f "$@" | dirname-)";;
		# note:  don't use `cd_dot "path/dir"`
		# to cd to phisical location to folder,
		# there is already `cd -P .`
	esac
}
