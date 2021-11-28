#!/bin/sh

# USAGE: YN_confirm [prompt text] [default when no input] [default when wrong input]
# example: YN_confirm 'Do somethhing harmless?' Y # will exit-stat 0, exept when user speciy [nN]*
# example: YN_confirm 'Do somethhing recomended?' y # will exit-stat 0 exept when user gives .....???????
# example: YN_confirm 'Do somethhing recomended?' Yes # will exit-stat 5 exept when ?????....
YN_confirm() {

	#set -- "${1:-}" "${2:-}"
	# when the shell has set -u -> ${foo:-}

	local yn_prompt;yn_prompt='[y/n]'
	case ${2-} in
		[Yy]|[Yy]es) yn_prompt='[Y/n]';;
		[Nn]|[Nn]o) yn_prompt='[y/N]';;
		'') ;;
		*) printf %s\\n >&2 "YN_confirm: ignring wrong argument: $2";;
	esac

	printf %s "${1:-}${1:+ }$yn_prompt "

	local respond;respond=''
	read respond </dev/tty || {
		case ${2:-} in [Yy]es) return 0; esac
		return 5
	}

	# When cant read:
	# read respond  || \
		# if [ "$2" = y ] || [ "$2" = Y ]
		# then return 0
		# else return 4
		# fi
		## For now fail to read  is not important,
		## still will take default option, respond remains '' 
	
	
	case $respond in
		[Yy]*) return 0;;
		[Nn]*) return 1;;
		'')
			case ${2:-} in [Yy]*) return 0; esac
			return 2
		;;
		*)
			case ${2:-} in [YN]*) return 0; esac
			return 3
		;;
	esac
}

case "${0##*/}" in
	YN_confirm|YN_confirm.sh) YN_confirm "$@";;
	*) ;;
esac
# YN[-_]confirm) YN_confirm "$@";;
# *) alias YN-confirm=YN_confirm;;



#
#""" # bat -r23:38 /usr/share/yash/initialization/common
#  23   │   history()
#  24   │   if [ -t 0 ] && (
#  25   │     for arg do
#  26   │       case "${arg}" in
#  27   │         (-[drsw]?* | --*=*) ;;
#  28   │         (-*c*) exit;;
#  29   │       esac
#  30   │     done
#  31   │     false
#  32   │   ) then
#  33   │     printf 'history: seems you are trying to clear the whole history.\n' >&2
#  34   │     printf 'are you sure? (yes/no) ' >&2
#  35   │     case "$(head -n 1)" in
#  36   │       ([Yy]*) command history "$@";;
#  37   │       (*)     printf 'history: cancelled.\n' >&2;;
#  38   │     esac
#
