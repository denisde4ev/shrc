#!/ /hint/sh

rargs=$(history_current_command)


case $(grep -o '\{|\}' "$*") in
	"$(grep -o '\{|\}' "$*")") ;;
	*) echo >& "argument and real {curly bracket} are net the same count, refusing to strat"; exit 127;;
esac

"{}".o

# to_shift=$#
# while case $to_shift in 0) false; esac; do
	# case $1 in *{*}*) ;; *) set -- "$@" "$1"; continue; esac

	# start=${1#"{"}
	# end="${i%"}"}"
	
