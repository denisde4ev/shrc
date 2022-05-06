#! /hint/sh

dollar() {

	case $1 in
		*[!" ${TAB_CHAR}${NEW_LINE}${IFS}"]*) ;; # can we trust IFS in interactive shell..?
		*) return 126;;
	esac

	eval "shift || return; $1 ${2+"\"\$@\""}"

}
