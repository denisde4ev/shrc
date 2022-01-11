
_cd_dot() { # alias cd.
	case $# in
		0) cd -P .;;
		*)
			local i;i=$(readlink -f "$@");
			if [ -d "$i" ]; then
				cd "$i"
			else
				cd "${i%/*}"
			fi
			i
		;;
		# note: `cd_dot "path/dir"`
		# yet another way to cd to phisical location to folder,
		# there is already `cd -P .`
	esac
}
