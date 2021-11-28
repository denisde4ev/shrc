#!/ hint/sh

_type_() {
	[ -t 1 ] && type "$@"
	which "$@"
}

alias '?=_type_' '??=_type_ -a' # ?- is from ~/B/a
