
i=$#

case $i in
0)
	unset i
	false
	;;
???*)
	echo eval \
		"i=\${$#};" \
		"set -- $(seq "$(( i - 1 ))" | sed 's/^/"\${/;  s/$/}" \\/; $ a;')" \
	;
	# [ $# -eq $(( i - 1 )) ] # i have already been changed...
	;;
*)
	while case $i in 1) false; esac; do
		set -- "$@" "$1"
		shift
		i=$(( i - 1 ))
	done
	i=$1; shift
esac
