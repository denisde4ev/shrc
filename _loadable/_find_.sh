
_find_() {
	\find "$@" \( -type f -printf %p\\n , \( -type d -printf %p/\\n  \) \)
}
