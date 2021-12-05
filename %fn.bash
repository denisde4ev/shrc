#!/ /hint/bash

CAT() { # move cursor as I press arrow keys --> unbuffered raw cat
	while IFS= read -r -n 1 -s i && [[ $i != $'\4' ]]; do
		printf %s "${i:-$'\n'}"
	done
}

CAT_sleep() { #  add some sleep between chars
	local OPTIND=1 || return
	[ "$1" != --help ] && getopts t: _ || { echo "usage: CAT_sleep -t <sleep-time> [cat args]" >&2; return 1; }
	shift $((OPTIND-1))
	while IFS= read -r -n 1 -s i && [[ $i != $'\4' ]]; do
		printf %s "${i:-$'\n'}"
		sleep "$sleep_time"
	done
}

arg() {
	[[ -t 1 && -t 2 ]]&&(IFS=;i=$*;echo -n "$#:${#i} ") >&2
	echo "${@@Q}"
}


