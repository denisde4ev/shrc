
_type_() {
	[ -t 1 ] && \type "$@"
	which "$@"
}
