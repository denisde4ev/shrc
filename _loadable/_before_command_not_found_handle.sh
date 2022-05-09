
_before_command_not_found_handle() {
	while :; do # goto: continue
	case $1 in
	[a-zA-Z0-9]*.)
		unset-unseted-i; local i
		i=${1%.};
		YN_confirm N "Run '$i${*#"$i."}' and return?" && { # note if cant read will return 0
			shift
			eval " $i" "${1+\"\$@\"}"& # NOTE: this won't exit the main shell, reason: in bash command_not_found_handle is in subshell
			return
			unset-seted-i
			return
		}
		unset-seted-i
		break # no need to print comm. n. fonud
		;;
	esac
	break; done # goto break

	if command. command_not_found_handle; then
		command_not_found_handle "$@"
	fi

}
