
arg() {
	[[ -t 1 && -t 2 ]] && {
		local IFS=''
		unset-unseted-i
		local i; i=$*
		printf %s "$#:${#i} " >&2;
		unset-seted-i
	}
	echo "${@@Q}"
}
