
case $# in
	0) unset i; false;;
	*)
		i=$#
		i=${!i}
		set -- "${@:1:$#-1}"
	;;
esac
