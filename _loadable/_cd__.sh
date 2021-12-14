#! /hint/sh


_cd__() { # alias 'cd..' '..'
	local OPTIND=1 || return; getopts '' i && { echo "this $i command does not support arguments" >&2; return 2; }
	shift $((OPTIND-1)) # shift the '--'

	# TODO usage and maybe list


	local i

	case $@ in
		0|*[!0-9]*) ;;
		[!0]*) # if arg is positive num, todo fix?
			cd -- "$(
				i=${1:-1}
				while [ 0 -lt "$i" ]; do
					printf %s ../
					i=$(( i - 1 ))
				done
			)"
			return
		;;
	esac

	case $# in
		0) cd ..;;
		1)
			case $1 in # match $1 arg - when only 1 arg
				npm|node) i="$(npm root)" && cd -- "${i%/node_modules}";;
				git) cd -- "$(git rev-parse --show-toplevel)";;
				/) cd -- /;;
				'~') cd -- '/~arcowo';; # hard-coded path
				root) cd -- ~root;;
				dow|dl|downloads) cd -- "${XDG_DOWNLOAD_DIR:-"$HOME/Downloads"}";;
				doc|docs|documents) cd -- "${XDG_DOCUMENTS_DIR:-"$HOME/Documents"}";;
				desk|desktop) cd -- "${XDG_DESKTOP_DIR:-"$HOME/Desktop"}";;
				pic|p|pics) cd -- "${XDG_PICTURES_DIR:-$HOME/Pictures}";;
				ss|shot|screenshots) cd -- "${XDG_PICTURES_DIR:-$HOME/Pictures}/Screenshots";;


				GH|gh) cd -- ~/0/GH;;
				[Bb]) cd -- ~/B;;

				*/*) cd -- "${@%/*}";;
				@*) i=/~/0/chroots/"${1#@}"; if [ -d "$i" ]; then cd "$i" && ll -d - "$i"; else _cd__ which-ll "$1" && return; fi;;
				*) echo >&2 not matched; return 2;;
			esac
			printf %s\\n "cd -- $(quote "$PWD")"
		;;
		*)
			case $1 in # match $1 arg - when more args
				which|which-ll)
					i=$1; shift

					path="$(which "$@")" || return
					case $path in */*) _cd__ "$path" || return; esac
					case $i in which-ll) ll -d -- "$PWD/$@" || return; esac
				;;
				*) echo >&2 not matched; return 2;;
			esac
		;;
	esac
}
