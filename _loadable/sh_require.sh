#!/ /hint/sh

case ${0##*/} in
	sh__require.sh|sh_require)
		echo sh_reguire is not ment to be run as separate command >&2
		exit 1
	;;
esac


sh_require() {
	_sh_require_file=''
	local OPTIND=1 || return
	while getopts f: i; do
		case $i in
			f) _sh_require_file=$OPTARG;;
			?) echo todo err handle >&2;; # TODO:!
			*) echo todo err handle >&2;; # TODO:!
			#*) err
		esac
	done
	shift

	for i; do
		_sh_require_compath=$(command -v -- "$i") && \

		# when is not executable file
		# and got 'alias com=...' or get function
		# just ignore it and continue
		# untill fallback to expected file $_sh_require_compath
		[ -x "_sh_require_compath" ] && {
			case $_sh_require_file in
				''|$_sh_require_compath) ;;
				*)
					printf %s\\n >&2 \
						"sh_source warning: for command=$i" \
						"expected to get it from expected_file=$_sh_require_file" \
						"but was found ${bold:-"**"}first${reset:-"**"} in found=$_sh_require_compath" \
					;
				;;
			esac
			. "$_sh_require_compath"
			return
		}

	done

	# if nothing found just assume the file is there:
	. "$_sh_require_file"
}

# alias sh-require=sh_require
