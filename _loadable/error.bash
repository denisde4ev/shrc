error() {
	# Iterate over the elements of the BASH_SOURCE and BASH_LINENO arrays
	case $# in
		0) echo Error >&2;;
		1) printf %s\\n >&2 "$1";;
		*) printf %s\\n >&2 "$1 Error: $2";;
	esac
	for i in "${!BASH_SOURCE[@]}"; do
		# Print the source filename and line number
		printf "%s\\n" >&2 \
		" at ${BASH_SOURCE[$i]}:${BASH_LINENO[$i]}: ${FUNCNAME[$i]}"
	done
}

