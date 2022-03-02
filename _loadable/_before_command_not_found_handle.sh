
_before_command_not_found_handle() {
	case $1 in
	[a-zA-Z0-9]*.)
		i;local i
		i=${1%.};
		YN_confirm n "Run '$i${*#"$i."}' and exit?" && {
			shift
			eval "$i" "$@" # NOTE: this won't exit the main shell, reason: in bash command_not_found_handle is in subshell
			exit
			I
			return
		}
		I
		;;
	esac
	if command. command_not_found_handle; then
		( command_not_found_handle "$@"; )
	fi
}
