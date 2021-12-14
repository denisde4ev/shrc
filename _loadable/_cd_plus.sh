
_cd_plus() { # alias cd+
	! [ -d "$1" ] || return 1
	case $1 in
		https://git*|https://*.git|"${1%%[:/]*}:"*/*)     # line from `which +` + */*
			+ "$1"
			return
		;;
	esac
	mkdir -- "$1" && cd "$1"
}
