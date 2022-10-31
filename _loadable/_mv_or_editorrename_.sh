
_mv_or_editorrename_() {
	case $#:$1:$2 in
		# [3-8]:*|[1-9][0-9]*) ;; # if args 3 or more, skip the full chek
		1:[!-]*|2:-${1#-}:[!-]*) # if $#==1 && $1==[!-]* || $#==2 && $1==-* && $2==[!-]*
			\edit-rename ${2+"--args=$1"} "${2-$1}" # provide --args option only when 2 args (NOTE: _fallbackfn_edit_rename)
			return
		;;
	esac
	\mv "$@"
}


return
# OLD:
#
#_mv_or_editorrename_() {
#	case $# in [3-9]|[1-9][0-9]) ;; *)
#	case $#:$1:$2 in
#		0:*|1:-*) ;;
#		1:[!-]*|2:-${1#-}:${2#-})
#			arg \edit-rename ${2+"--args=$1"} "${2-$1}"
#			return
#		;;
#	esac
#	esac
#	\mv "$@"
#}
#
