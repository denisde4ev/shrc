
sleep_untill(){
	# IF ANY TIME UNEXPECTED DIFFERENCES HAPPEN, THIS WONT BE THE ACCURATE TIME REQUIRED
	# SLEEPING ANG MAYBE POOR PERFORMANCE MIGHT CHANGE THE TIME SLEEP COMMAND EXITS
	# hover in most cases this is just too useful

	i{
		# when (one argument) && (does not start with -) then add prepend 1 arg '-d' (for date command)
		case $#:$1 in 1:[!-]*) set -- -d "$@"; esac

		i=$(date "$@" +%s) || return
		i=$(( i - $( date +%s ) )) || return

		set -- "$i"
	}i

	case $1 in
		-*) puts >&2 "can not sleep for the future: got sleep for $1 seconds"; return 1;;
	esac

	puts "sleeping for: $1"
	sleep "$1"
}
