#!/ /hint/sh


# NOT NEEDED, command_not_found_handle will load it 
# case $(command -v YN_confirm) in
# 	YN_confirm) ;;
# 	*)
# 		i=$(command -v YN_confirm.sh)
# 		case $i in
# 			*/*) . "$i";;
# 			*) { echo "err: can\'t load YN_confirm function" >&2; return; exit; };;
# 		esac
# 		# # require function YN_confirm from YN_confirm
# 		# command -v sh_require >/dev/null || . /~arcowo/bin/shsource.d/sh_require.sh
# 		# case $i in
# 		# 	sh_require) ;; # all ok sh_require is function
# 		# 	'alias sh_require='?*) ;; # still hope it is ok ..
# 		# 	*/*) . "$i" || ;;
# 		# 	*)
# 		# 		echo "can't get the required function 'sh_require'"
# 		# 		false
# 		# 	;;
# 		# esac || return || exit
# 		# ;
# 		# sh_require -f /~arcowo/bin/YN_confirm YN_confirm YN_confirm || return || exit
# 	;;
# esac


_plus_() {

local nl;nl='
'	# just a New Line


	case $@ in -h|-\?|--help|'')
		printf %s\\n \
			'Usage:' \
			'parsing arg1 by:' \
			'  <+|x> <file_command> [...execute_args] => chmod +x $file_command && ./$file_command $execute_args' \
			'  <chmod-arg1> ...args/files             => chmod @' \
			'  <git_url> [...args] [dir]              => git clone @ && cd ${dir:-$git_url}' \
			'  <url>                                  => wset @' \
			'  <file_path>                            => cd $(dirndme $file_path)' \
			'  _plus_                                 -> used for debugging, reloads fn +  => (. alias +=_plus_ && alias +=_plus_ )' \
			'' \
			'before any action, user is prompted to confirm' \
			'note: cd wont work if is run in separate shell or subshell' \
		;
		case ${0##*/} in
			+|_plus_) printf %s\\n '  - you are useing separate shell -  '
		esac

		return
	esac



	_plus__no_opt() { # dont give me arguments
		for i do
			case $i in
				-*) return 1
			esac
		done
		return 0
	}

	cmdv() { # verbose the cmd
		case $- in
			*x*)
				: ::: 'XTRACE DETECTED => WILL NOT USE:' 'set +x' ::: :
				"$@"
			;;
			*)
				local PS4;PS4=' \$ '
				set -x # TODO: trap set +x
				"$@"
				{ # this block code in MOST shells will not print
					# local _lastexitstat;_lastexitstat=$?
					# set +x;
					# return "$_lastexitstat"

					eval "set +x; return $?"
					# not the best,
					# but no additional virable will be needed (last_ex_code=$?; "$@"; return $?;  $ echo $last_ex_code; echo NOooooo WHY I HAVE THIS VAIRABLE IN GLOBAL SCOPE)
					# we are in users shell, and local is not "POSIX sh"
					# so keep it clean
				} 1>/dev/null 2>/dev/null
			;;
		esac
	}



	case $1 in +|x)
		YN_confirm " \$ chmod +x \$1$nl   #" y && {
			shift # remove the (+|x)
			cmdv chmod -v +x -- "$1" || return
			cmdv ll -d -- "$1"
			YN_confirm " \$ \"\$@\"$nl   #" y && {
				case $1 in
					*/*) cmdv "$@";;
					*) cmdv ./"$@";;
					# or use 'PATH=.:$PATH'
				esac
			}
			return
		}
	esac

	case $1 in [0-9][0-9][0-9]|[0-9][0-9][0-9][0-9]|[ugo][+-=]*|[+-=][rwx]*)
		YN_confirm " \$ chmod '$1' \$@$nl   #" y && {
			cmdv chmod -v -- "$@" || return
			shift # remove MODE arg1
			cmdv ll -d -- "$@"
			return
		}
	esac


	case $1 in
		-*|file:*) false;;
		git@?*) true;;
		http://[!/]*|https://[!/]*)
			# same as js: switch ( $i.replace(/.*:\/\//,'') )
			case ${1#"${1%%"://"*}://"} in 
				git*/[!/]*|*[!/]/git*|*[!/]*.git) true;;
				*) false;;
			esac
		;;
		# same as js: /\/.*:/.test(i)
		*/*:*) false ;;
		# same as js: /^[^\/]+\w:\w[^\/]+$/.test(i)
		[!:]*[A-Za-z0-9_]:[A-Za-z0-9_]*[!:]*) true;;
		*) false;;
	esac && YN_confirm " \$ git clone \$@ && cd \$_$nl   #" y && {
		giturl=$1
		if [ "${2:-}" != '' ] && _plus__no_opt "$2"; then
			dir=$2
			shift "$(( $# < 2 ? $# : 2 ))" # shift 2 or less
		else
			dir=$(basename -- "$1" .git)
		fi


		if _plus__no_opt "$dir"; then
			cmdv git clone "$giturl" "$dir" "$@" && \
			cd "$dir"
			return
		else
			echo >&2 "Note: $dir includes -dash, will pit '--' AND additional arguments will be ignored"
			cmdv git clone -- "$giturl" "$dir" && \
			cd ./"$dir" &&  { ll 2>/dev/null || :; }
			return
		fi
		cd_warning
		# TODO:! cd_warning fn
	}

	# case ${1%%[:/]*} in http|https)
	case $1 in http:?*[a-zA-Z0-9_]*|https:?*[a-zA-Z0-9_]*)
		YN_confirm " \$ wget \$@$nl   #" y && {
			cmdv wget -c -v "$@"
			return
		}
	esac


	case $1 in */*)
		YN_confirm " \$ cd.. \$@$nl   #" y && {
			cmdv cd.. "$@"
			return
			cd_warning
		}
	esac



	case $1 in _plus_) # just easy way to reload the function
		case ${0##*/} in +|_plus_) echo >&2 "Will not take effect"; esac

		sh_require -f "/~arcowo/bin/shsource.d/+" + _plus_ || return || exit
		alias +=_plus_
	esac


	echo >&2 Nothing to do
	return 126 # 127 -1 = 126 comman/action not found (todo: find if this is the ?convention?)
}

# todo, is it needed?
# case $1 in
	# _plus_) ;;  # Dont create recursion
	# *)
	# ;;
# esac

case ${0##*/} in
	_plus_|+|_plus_.sh|+.sh) _plus_ "$@";;
	*) alias +=_plus_;;
esac
