#! /hint/sh

# pwd=_pwd_
_pwd_() {
	case $1 in
	'')
		\pwd | grep --color /
		;;
	-*)
		\pwd "$@"
		;;
	*)
		unset-unseted-i
		for i; do
			printf %s\\n "$PWD/$i"
		done
		unset-seted-i
	esac
}
