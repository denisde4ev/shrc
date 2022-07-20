# for i; do # TODO: I'm not so shure for this loop..
if [ -t 1 ]; then
	case ${LSLONG_COMMAND-} in
		*[!"$IFS"]*) exec ${LSLONG_COMMAND} "${ll_or_print?}";;
		*)           exec ls -al            "${ll_or_print?}";;
	esac
else (
	set -- "${ll_or_print?}"/*
	if [ -e "$1" ]; then
		printf %s\\n "$@"
	else
		err "note: no backups..." 0
	fi
) fi
#done
#unset i # noo.. just dont use var
