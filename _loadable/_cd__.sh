
# TODO: separate CD and cd.. command/fn/aliases

_cd__() { # alias 'cd..' '..'
	local OPTIND=1 || return
	i{
	getopts '' i && {
		echo "${FUNCNAME-_cd__}: fn does not support arguments, got arg: '$i'" >&2
		I
		return 2
	}
	}i
	shift $((OPTIND-1)) # shift the '--'


	local i

	# TODO: (this one still works if uncomment)
	case $@ in
		0|*[!0-9]*) ;;
		[!0]*) # if arg is positive num, todo fix?
			cd "$( i{
					i=${1:-1}
					while [ 0 -lt "$i" ]; do
						printf %s ../
						i=$(( i - 1 ))
					done
			}i )"
			return
		;;
	esac

	
					 # todo: '}i' wont keep return status

	case $# in # todo: move most of this to new fn cd-i?
		0) cd ..;;
		1)
			case $1 in # match $1 arg - when only 1 arg
				npm|node) i{; i="$(npm root)" && cd "${i%/node_modules}"; }i;;
				git)                            cd "$(git rev-parse --show-toplevel)";;

				torrents)                       cd ~/d/' '/torrents;;
				torrentss)                      cd ~/d/' '/torrentss;;
				[Vv][Bb]ox|[Vv]irtual[Bb]ox)    cd ~/d/' '/VirtualBoxVMs;;
				[Vv][Bb]oxs|[Vv]irtual[Bb]oxs)  cd ~/d/' '/VirtualBoxVMss;;

				dow|dl|downloads|download)      cd "${XDG_DOWNLOAD_DIR:-"$HOME/Downloads"}";;
				doc|docs|documents|document)    cd "${XDG_DOCUMENTS_DIR:-"$HOME/Documents"}";;
				desk|desktops|desktop)          cd "${XDG_DESKTOP_DIR:-"$HOME/Desktop"}";;
				pic|p|pics|pic)                 cd "${XDG_PICTURES_DIR:-$HOME/Pictures}";;
				ss|shot|screenshots|screenshot) cd "${XDG_PICTURES_DIR:-$HOME/Pictures}/Screenshots";;
				did|/did)                       cd /dev/disk/by-id;; # also /did is my symlink to it
				todo|TODO)                      cd "${TODO_DIR:-"$HOME/0/TODO.d"}";;

				http*|https*) # TODO: consider should thsi code be here or in other fn, like cd+/cd-
					case $1 in
						http://?*.?*/*|https://?*.?*/*) i{
							i=${1#http}; i=${i#s}; i=${i#://}
							i=/^/\ https:/"${i%/*}"
							[ -d "$i" ] || mkdir -pv -- "$i"
							cd "$i"
							i=${1##*/}; i=${i%.git}
							[ -d "$i" ] || git clone -- "$1" "./$i"
							cd "./$i"
						}i;;
						*) cd /^/\ https:;;
					esac
				;;

				/did__/*) i{
					i=$(readlink -f $1) && \
					sudo mount -v /dev/"${i##*/}" /mnt/_/"${i##*/}" &&
					{
						cd "/mnt/did/${1}"
					}
				}i;;
				/did/*|/dev/*) i{ # TODO: move this to new cd-i fn.
					if [ -L "$1" ]; then
						i=$(readlink -f "$1")
					else
						i=$1
					fi && \
					cd /mnt/_/"${i##*/}" || return
					if (
						# also auto mount it if folder is empty (not porpper mount detection but it good enugh)
						{
							# if empty  
							set -- /mnt/_/"${i##*/}"/* && \
							[ ! -e "$1" ]
						} && {
							# if empty then mount it
							sudo mount -v /dev/"${i##*/}" /mnt/_/"${i##*/}"
						}
					); then
						cd /mnt/_/"${i##*/}"
					fi
				}i;;

				*/*) cd "${@%/*}";; # my favorite one: `cd.. /dir/to/file` will result in `cd /dir/to`

				@*) i{
					i=/~/0/chroots/"${1#@}"
					if [ -d "$i" ]; then
						cd "$i" && \
						ll -d -- "$i"
					else
						_cd__ which-ll "$1" && return
					fi
				}i ;;
				_[a-zA-Z]*) if [ -e ~/B/"$@" ]; then cd ~/B/"$@"; else cd ~/B/"$@"*; fi ;;
				*) echo >&2 1 arg, not matched; return 2;;
			esac
			printf %s\\n "cd $(quote "$PWD")"
		;;
		*)
			case $1 in # match $1 arg - when more args
				which|which-ll)
					set -- "$1" "$2" "$(which "$2")"
					# oh. this is just because can not unset i before calling same fn.
					# and also exit status is lost...

					case $3 in
						*/*) _cd__ "$3" || return $?;;
						*) puts >&2 "got bad path from which: '$3'"; return 1;;
					esac

					case $1 in which-ll) ll -d -- "$2"; esac
				;;
				*) echo >&2 not matched; return 2;;
			esac
		;;
	esac
}
