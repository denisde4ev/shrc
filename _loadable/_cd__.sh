#! /hint/sh
# TODO: separate CD and cd.. command/fn/aliases

_cd__() { # alias 'cd..' '..' 'CD'
	local i OPTIND=1 || return

	case $1 in -*) # note: not even '--' allowed.
		echo "${FUNCNAME-_cd__}: fn does not support arguments, got: '$1'" >&2
		return 2
	esac


	case $@ in 0|*[!0-9]*) ;; [!0]*) # if arg is positive num, todo fix?
		cd "$( unset-unseted-i; {
				i=${1:-1}
				while [ 0 -lt "$i" ]; do
					printf %s ../
					i=$(( i - 1 ))
				done
		} ;unset-seted-i )"
		return
	esac

	case $# in # todo: move most of this to new fn CD
		0) cd ..;;
		1)
			case $1 in # match $1 arg - when only 1 arg
				npm|node) unset-unseted-i; i="$(npm root)" && cd "${i%/node_modules}"; unset-seted-i;;
				git)                              cd "$(git rev-parse --show-toplevel)";;
				part)                             cd "$(get-part-mounted .)";;

				torrents)                         cd ~/d/' '/torrents;;
				torrentss)                        cd ~/d/' '/torrentss;;
				[Vv][Bb]ox|[Vv]irtual[Bb]ox)      cd ~/d/' '/VirtualBoxVMs;;
				[Vv][Bb]oxs|[Vv]irtual[Bb]oxs)    cd ~/d/' '/VirtualBoxVMss;;

				bin)                              cd ~/.local/bin;;
				B)                                cd ~/.config/bash/bashrc.d;;
				_loadable|loadable)               cd "$B"/_loadable;;
				__sourcable|_sourcable|sourcable) cd "$B"/__sourcable;;

				http|https|http:|https:)          cd '/^/ https:';;
				gh|GH)                            cd '/^/ https:/github.com';;
				gh|GH)                            cd '/^/ https:/github.com';;
				gh-dd|ghdd|g)                     cd '/^/ https:/github.com/denisde4ev';;

				dow|dl|downloads|download)        cd "${XDG_DOWNLOAD_DIR:-"$HOME/Downloads"}";;
				doc|docs|documents|document)      cd "${XDG_DOCUMENTS_DIR:-"$HOME/Documents"}";;
				desk|desktops|desktop)            cd "${XDG_DESKTOP_DIR:-"$HOME/Desktop"}";;
				pic|p|pics|pic)                   cd "${XDG_PICTURES_DIR:-$HOME/Pictures}";;
				ss|shot|screenshots|screenshot)   cd "${XDG_PICTURES_DIR:-$HOME/Pictures}/Screenshots";;
				did|/did)                         cd /dev/disk/by-id;; # also /did is my symlink to it
				todo|TODO)                        cd "${TODO_DIR:-"$HOME/.local/0/TODO.d"}";;

				http*|https*) # TODO: consider should this code be here or in other fn, like cd+/cd-
					case $1 in
						http://?*.?*/*|https://?*.?*/*)
							unset-unseted-i
							i=${1#http}; i=${i#s}; i=${i#://}
							i=/^/\ https:/"${i%/*}"
							[ -d "$i" ] || mkdir -pv -- "$i"
							cd "$i" || eval "unset-seted-i; return $?"
							i=${1##*/}; i=${i%.git}
							[ -d "$i" ] || git clone -- "$1" "./$i"
							cd "./$i" || eval "unset-seted-i; return $?"
							unset-seted-i
						;;
						*) cd /^/\ https:;;
					esac
				;;

				/did/*|/dev/*)
					unset-unseted-i
					if [ -L "$1" ]; then
						i=$(readlink -f -- "$1") || eval "unset-unseted-i; return $?"
					else
						i=$1
					fi && \
					cd /mnt/_/"${i##*/}" || eval "unset-unseted-i; return $?"
					if (
						# also auto mount it if folder is empty (not porpper mount detection but it good enugh)
						{
							# if empty  
							set -- /mnt/_/"${i##*/}"/* && \
							[ ! -e "$1" ]
						} && {
							# if empty then mount it
							sudo mount -v /dev/"${i##*/}" /mnt/_/"${i##*/}" || eval "unset-unseted-i; return $?"
						}
					); then
						cd /mnt/_/"${i##*/}"  || eval "unset-unseted-i; return $?"
					fi
					unset-seted-i
				;;

				*/*) cd "${@%/*}";; # my favorite one: `cd.. /dir/to/file` will result in `cd /dir/to`

				@*)
					unset-unseted-i
					i=/~/.local/0/chroots/"${1#@}"
					if [ -d "$i" ]; then
						cd "$i" && \
						ll -d -- "$i" \
						|| eval "unset-unseted-i; return $?"
					else
						_cd__ which-ll "$1"; eval "unset-unseted-i; return $?"
					fi
					unset-seted-i
				;;
				_[a-zA-Z]*) if [ -e "$B"/"$1" ]; then cd "$B"/"$1"; else cd "$B"/"$1"*; fi ;;
				*) puts "\$1='$1', not matched" >&2; return 2;;
			esac
			printf %s\\n "cd $(case $PWD in *'/ https:/'[!/]*) puts "$PWD" | sed 's@https:/@https://@g';; *) quote "$PWD"; esac)"
		;;
		# TODO: add case for `$# in 2)` aruments without breaking `case in .. *)` 
			#and add:
			##git-branch:*|gb:*)                cd "/^/_/git-branch:${1#*:}/ https:/github.com/denisde4ev/$2" || return;;
			# and maybe # which|which-ll)

		*)
			case $1 in # match first arg - when has more than 1 args
				which|which-ll)
					set -- "$1" "$2" "$(which -- "$2")"
					# dont: change `set -- ...` to `unset-i; i=...`
					# reason: can not unset i before calling same fn '_cd__'!

					case $3 in
						*/*) _cd__ "$3" || return;; # NOTE: one time recursion here
						*) puts >&2 "got bad path from which: '$3'"; return 1;;
					esac

					case $1 in which-ll) ${LSLONG_COMMAND:-ls -al} -d -- "$2"; esac
				;;
				*)  puts "\$1='$1', not matched" >&2; return 2;;
			esac
		;;
	esac
}
