
arg() {
	[[ -t 1 && -t 2 ]] && {
		local IFS=''
		ii
		local i; i=$*
		printf %s "$#:${#i} " >&2;
	}
	echo "${@@Q}"
}
