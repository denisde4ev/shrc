
_type_() {
	local o=()
	local a=()
	[[ ! -t 1 && " $*" != ' -' ]] && a+=(-p)
	while (( $# )); do
		case $1 in
			--) break;;
			-*) o+=("$1");;
			*) a+=("$1");;
		esac
		shift
	done
	\type "${o[@]}" "${a[@]}" "$@"
}
