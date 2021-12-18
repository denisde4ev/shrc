
__load_loadable_byfile(){
	${2+unalias "$2"}
	. ~/B/_loadable/"$1"
	shift 1
	${1+"$@"}
}
