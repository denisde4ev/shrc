#! /hint/sh

#_cdt_auto_cleanup() {
	case ${cdt+x} in x)
		\rmdir >&2 -v -- "$cdt" || {
			printf %s\\n "@${EPOCHSECONDS-$(date +%s)} " >> "$cdt/.detached"
			\mv -vT -- "$cdt" "${cdt}_"
		}
	esac
#}




#case $BASH_SOURCE in
#	*/_cleanup/_cdt_auto_cleanup.sh)
#	_cdt_auto_cleanup
#	;;
#	*/_loadable/_cdt_auto_cleanup.sh) ;;
#	#*) ;; idk, nothing for now
#esac
