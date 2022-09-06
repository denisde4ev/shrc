
__load_loadable_byfile(){
	${2+unalias "$2"}
	. "$B"/_loadable/"$1"
	shift 1
	${1+"$@"}
		# todo: check if its needed to detect if $1 is empty.
		# and shouldn't it actually check if its missing and empty? ${1+-$@}
}
