#! /hint/sh


_cd__() { # alias 'cd..' '..'
	local OPTIND=1 || return
	getopts '' i && {
		echo "${FUNCNAME-_cd__}: fn does not support arguments, got arg: '$i'" >&2
		return 2
	}
	shift $((OPTIND-1)) # shift the '--'


	local i

	# TODO: (this one still works if uncomment)
	# case $@ in
		# 0|*[!0-9]*) ;;
		# [!0]*) # if arg is positive num, todo fix?
			# cd "$(
				# i=${1:-1}
				# while [ 0 -lt "$i" ]; do
					# printf %s ../
					# i=$(( i - 1 ))
				# done
			# )"
			# return
		# ;;
	# esac

	case $# in
		0) cd ..;;
		1)
			case $1 in # match $1 arg - when only 1 arg
				npm|node) i="$(npm root)" && cd "${i%/node_modules}";;
				git)                             cd "$(git rev-parse --show-toplevel)";;
				/)                               cd /;;
				'~')                             cd '/~arcowo';; # hard-coded path
				root)                            cd ~root;;
				dow|dl|downloads|download)       cd "${XDG_DOWNLOAD_DIR:-"$HOME/Downloads"}";;
				doc|docs|documents|document)     cd "${XDG_DOCUMENTS_DIR:-"$HOME/Documents"}";;
				desk|desktops|desktop)           cd "${XDG_DESKTOP_DIR:-"$HOME/Desktop"}";;
				pic|p|pics|pic)                  cd "${XDG_PICTURES_DIR:-$HOME/Pictures}";;
				ss|shot|screenshots|screenshot)  cd "${XDG_PICTURES_DIR:-$HOME/Pictures}/Screenshots";;
				did)                             cd /dev/disk/by-id;; # also /did is my symlink to it
				todo|TODO)                       cd ~/0/TODO.d;;
				GH|gh)                           cd ~/0/GH;;
				[Bb])                            cd ~/B;;
				http*|https*)
					case $1 in
						http://?*.?*/*|https://?*.?*/*) i{
							i=${1#http}; i=${i#s}; i=${i#://}
							i=/^/\ https:/"${i%/*}"
							[ ! -d "$i" ] || mkdir -pv -- "$i"
							cd "$i"
						}i;;
						*) cd /^/\ https:;;
					esac
				;;

				/dev/*|/did/*) i{; i=$(readlink "$1") && cd /mnt/"${i##*/}" && }i;; # todo: '}i' wont keep return status

				*/*) cd "${@%/*}";; # my favorite one: `cd.. /dir/to/file` will result in `cd /dir/to`

				@*) i{
					i=/~/0/chroots/"${1#@}"
					if [ -d "$i" ]; then
						cd "$i" && \
						ll -d -- "$i"
					else
						_cd__ which-ll "$1" && return
					fi
					i
				}i ;;
				_[a-zA-Z]*) if [ -e ~/B/"$@" ]; then cd ~/B/"$@"; else cd ~/B/"$@"*; fi ;;
				*) echo >&2 1 arg, not matched; return 2;;
			esac
			printf %s\\n "cd $(quote "$PWD")"
		;;
		*)
			case $1 in # match $1 arg - when more args
				which|which-ll) i{
					i=$1; shift

					path="$(which "$@")" || return
					case $path in */*) _cd__ "$path" || return; esac
					case $i in which-ll) ll -d -- "$PWD/$@" || return; esac
					i
				}i ;;
				*) echo >&2 not matched; return 2;;
			esac
		;;
	esac
}
