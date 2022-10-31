
arg() {
	if [[ -t 1 && -t 2 ]]; then
		local IFS=''
		unset-unseted-i
		local i; i=$*
		printf %s "$#:${#i} " >&2;
		unset-seted-i
	fi
	echo "${@@Q}"
}
