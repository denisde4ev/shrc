#! /hint/sh

_pwd__in_btrfs() { # todo
	##puts >&2 'todo: nothing done'
	##return 123 # not done

	local date
	case $1 in
		@[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9])
			date=${1#@}
		;;
		/mnt/@/*)
			date=$1
			date=${date#"/mnt/@/"}
			case $date in
				snapshots/*) date=${date#snapshots/};;
				s/*) date=${date#s/};;
			esac
			date=${date%%/*}
			case $date in [0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]) ;; *) false;; esac
		;;
		*) false;;
	esac || {
		echo _pwd__in_btrfs: bad argument >&2
		return 2
	}

	local pwd=${pwd-$PWD}
	#local pwd=$PWD
	case $#:$2 in
		2:/*) pwd=$2; shift 2;; # DO: duplicate this check+shift in upper function BECAUSE we cannot shift inside of functions
		*) shift;;
	esac


	case $pwd in [!/]*) pwd=$PWD/$pwd; esac # simple realpath

	case $pwd in
		/^/*) pwd=/v/${pwd#"/^/"};; # this .. becouse how my symlinks are linked
		"/~$USER/"*|/~/*) pwd=/home/$USER/${pwd#/*/};;
		# TODO: CHECK if there are more complex paths based on my /etc/fstab (or other symlinks, but probably not by symlinks)
	esac


	case $pwd in
		/home/*) printf %s\\n "/mnt/@/snapshots/$date/@home/${pwd#/}";;
		*)       printf %s\\n "/mnt/@/snapshots/$date/@rootfs/${pwd#/}";;
	esac

}


_pwd__path_to_urlpath() {
	local pwd=$1
	case $pwd in
		#/0/gh/...) pwd='/^/ https://github.com/denisde4ev';;
		/0/gh/.../*) pwd="/^/ https://github.com/denisde4ev/${pwd#"/0/gh/.../"}";;
		/0/gh/*)
			pwd=${pwd#"/0/gh/"} # myrepo/path1/path2
			# NOTE: assuming it's master branch
			case $pwd in
				*/*) pwd="/^/ https://github.com/denisde4ev/${pwd%%/*}/tree/master/${pwd#*/}";;
				*) pwd="/^/ https://github.com/denisde4ev/${pwd}/tree/master";;
			esac
		;;

		#/^/' https:///'*)
		#	pwd=${pwd#/^/' https:///'};
		#	pwd=/^/' https://'"${pwd#"${pwd%%[!/]*}"}"
		#;;
		/^/' https://'*) ;; # all good
		/^/' https:'*)     pwd=/^/' https:/'${pwd#/^/' https:'};;
		/^/'%20https:'*)   pwd=/^/' https:/'${pwd#/^/'%20https:'};;
		/^/'https:'*)      pwd=/^/' https:/'${pwd#/^/'https:'};;
		/^/' https%3A'*)   pwd=/^/' https:/'${pwd#/^/' https%3A'};;
		/^/'%20https%3A'*) pwd=/^/' https:/'${pwd#/^/'%20https%3A'};;
		/^/'https%3A'*)    pwd=/^/' https:/'${pwd#/^/'https%3A'};;

		/^/' '[a-zA-Z]*''*)   pwd=/^/' https://'${pwd#/^/' '};;
		/^/'%20'[a-zA-Z]*''*) pwd=/^/' https://'${pwd#/^/'%20'};;
		/^/''[a-zA-Z]*''*)    pwd=/^/' https://'${pwd#/^/''};;
		*) printf %s\\n "$pwd"; return 1;;
	esac

	printf %s\\n "$pwd"
}

_pwd__gh_url_modify() {
	# replace type in `.../raw/...` to `blob|tree|raw` based on arg
	# TODO: reconsider what is the best behavior of this,
	# the detection works fine, but I'm not shure that it shoul be based on arg count 0|1|>1

	local pwd=$1; shift

	local _pwd__gh_url_modify__t
	case $1 in
		--raw|--blob|--tree) _pwd__gh_url_modify__t=${1#--}; shift;;
		*) unset _pwd__gh_url_modify__t;;
	esac


	while :; do
		local gh_urlpath
		gh_urlpath=${pwd#'/^/ https://github.com/'}
		#case $pwd in "$gh_urlpath") gh_urlpath=${gh_urlpath#'/^/ https:/github.com/'}; esac
		# gh_urlpath = username/repo/raw/master/path/to
		case $gh_urlpath in ""|"$pwd") break; esac
		
		local gh_uname_n_reponame
		local gh_branch_n_repopath

		gh_branch_n_repopath=${gh_urlpath#*/*/}; case $gh_branch_n_repopath in ""|"$gh_urlpath") break; esac # gh_branch_n_repopath=raw/master/path/to
		case $gh_branch_n_repopath in raw/*|tree/*|blob/*) ;; *) break; esac
		gh_uname_n_reponame=${gh_urlpath%"/$gh_branch_n_repopath"}; case $gh_uname_n_reponame in ""|"$gh_urlpath") break; esac # gh_uname_n_reponame=username/repo
		gh_branch_n_repopath=${gh_branch_n_repopath#*/} # master/path/to

		# gh_uname = username

		case ${_pwd__gh_url_modify__t:+t} in t) ;; *)
			#local t
			case $#:$1 in
				0:*|1:*/) _pwd__gh_url_modify__t=tree;;
				1:*)
					if [ -f "./$1" ]; then
						_pwd__gh_url_modify__t=raw
					elif [ -d "./$1" ]; then
						_pwd__gh_url_modify__t=tree
					#else
					#	_pwd__gh_url_modify__t=blob
					fi
				;;
				#*) _pwd__gh_url_modify__t=blob;;
			esac
		esac
		pwd="/^/ https://github.com/$gh_uname_n_reponame/${_pwd__gh_url_modify__t:-blob}/$gh_branch_n_repopath"


		printf %s\\n "$pwd"
		return 0
	break; done

	printf %s\\n "$pwd"
	return 1
}

#_pwd_color_slashes() {
#	[ -t 1 ] || { printf %s\\n "$@"; return; }
#	local red="$(printf '\033[31m')"
#	local reset="$(printf '\033[0m')"
#
#	local buffer=$1
#
#	local prefix
#	local rest
#	while :; do
#		case $buffer in
#			*/*)
#				prefix=${buffer%%/*}
#				rest=${buffer#*/}
#				printf %s "$prefix$red/$reset"
#				buffer=$rest
#				;;
#			*)
#				printf '%s\n' "$buffer"
#				break
#				;;
#		esac
#	done
#}

_pwd_() {

	case $1 in
		--help) printf %s\\n "_pwd_ [-] [-P] [--raw|--tree|--blob] [@YYYY-MM-DD] [--] [files...]"; return;;
	esac

	# todo: support unordered arguments

	#local pwd # nah, give the var to shell
	case $1 in
		-) shift; pwd=$OLDPWD;; # unlike the original pwd, BUT WHY ORIGINAL PWD DOES `pwd -` '-'=ignored, why
		*) pwd=$PWD;;
	esac

	case $1 in
		#-P) shift; pwd=$(PWD=$pwd; \pwd -P);; # does not work like this
		-P) shift; pwd=$(cd "$pwd"; \pwd -P);; # TODO: what if oldpwd was removed ..., better use 'readlink -f'?
		--raw|--tree|--blob|--) ;;
		#-[!-]*|--*) \pwd "$@"; return;;
		-*) printf %s\\n >&2 "_pwd_: bad usage, check --help"; return 2;;
		*) ;;
	esac

	case $pwd in
		/gh/*) pwd="/0$pwd";; # 1 of my symlinks
	esac

	case $pwd in
		/0/gh|/0/gh/...) pwd='/^/ https://github.com/denisde4ev';;
		/0/gh/*|/^/*)
			pwd=$(_pwd__path_to_urlpath "$pwd") && \
			pwd=$(_pwd__gh_url_modify "$pwd" "$@")

			# or simply do this:
			#pwd=$(readlink -f -- "$pwd")
			#case $pwd in /^/' '[a-zA-Z]*''*) pwd=/^/' https://'${pwd#/^/' '};; esac
			case $1 in --raw|--tree|--blob) shift; esac
		;;
		*)
			case $1 in --raw|--tree|--blob)
				printf %s\\n >&2 "W: '$1' had no affect"
				shift
			esac
		;;
	esac

	case $1 in
		@*@home|/mnt/@/snapshots/*@home|/mnt/@/s/*@home) printf %s\\n >&2 "U: unimplemented @date@home snapshot pwd"; return 4;;# TODO:! parse with @home
		@*|/mnt/@/snapshots/*|/mnt/@/s/*)
			pwd=$(_pwd__in_btrfs "$@") || return
			case $#:$2 in # BECAUSE: we cannot shift inside of functions!
				2:/*) shift 2;;
				*) shift;;
			esac
		;;
	esac

	case $1 in --) shift; esac

	case $1 in
		'')
			printf %s\\n "$pwd"
			#_pwd_color_slashes "$pwd"
		;;
		*)
			local i || unset-unseted-i
			for i; do
				case $i in ./*) i=${i#./}; esac
				printf %s\\n "$pwd/$i"
				#_pwd_color_slashes "$pwd/$i"
			done
			#unset-seted-i
		;;
	esac | grep --color /

}
