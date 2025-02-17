
arg() {
	if [[ -t 1 && -t 2 ]]; then
		local IFS=''
		case ${shell_supports_local+x} in x);; *)
			unset-unseted-i
		esac
		local i; i=$*
		printf %s "$#:${#i} " >&2;
		case ${shell_supports_local+x} in x);; *)
			unset-seted-i
		esac
	fi
	echo "${@@Q}"
}
