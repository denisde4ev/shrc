#! /hint/sh
{
	unset i
	i=$#

	case $i in
	0)
		return 1
		;;
	???*)
		eval \
			"i=\${$i};" \
			"set -- $(seq "$(( i - 1 ))" | sed 's/^/"\${/;  s/$/}" \\/; $ a;')" \
		&& \
		[ $# -eq $(( i - 1 )) ]
	;;
	*) 
		while case $i in 1) false; esac; do
			set -- "$@" "$1"
			shift
			i=$(( i - 1 ))
		done
		i=$1; shift
	;;
	esac

}
