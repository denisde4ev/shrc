
i=$#

case $i in
0)
	unset i
	false
	;;
???*) # todo \|/
	eval \
		"i=\${$i};" \
		"set -- $(seq "$(( i - 1 ))" | sed 's/^/"\${/;  s/$/}" \\/; $ a;')" \
	&& \
	[ $# -eq $(( i - 1 )) ]
;;
*) # comparet this to eval method which one is faster and if one of them is unnecessary
	while case $i in 1) false; esac; do
		set -- "$@" "$1"
		shift
		i=$(( i - 1 ))
	done
	i=$1; shift
;;
esac
