
sleep_untill(){
	# IF ANY TIME UNEXPECTED DIFFERENCES HAPPEN, THIS WONT BE THE ACCURATE TIME REQUIRED
	# SLEEPING ANG MAYBE POOR PERFORMANCE MIGHT CHANGE THE TIME SLEEP COMMAND EXITS
	# hover in most cases this is just too useful

	i{
		case $#:$1 in 1:[!-]) set -- -d "$@"; esac
		i=$(date "$@" +%s) || return
		i=$(( i - $( date +%s ) )) || return
		set -- "$i"
	}i

	case $1 in
		-*) puts >&2 "can not sleep for future: got sleep for $1"; return 1;;
	esac
	puts "sleeping for: $1"
	sleep "$1"
}
