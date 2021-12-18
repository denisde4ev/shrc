
history_current_command__nosubshell() {
	local i
	{
		unset i
		IFS='' read -r i
		while IFS='' read -r j; do i="$j"; j=$i; done
		echo-1l "$r"
	} << EOF
$(history)
EOF
	) || return

	# handle format s/^ *[0-9]* *//
	i=${i#"${r%%[! ]*}"}   # trim start spaces
	i=${i#"${r%%[!0-9]*}"} # trim start digits
	i=${i#"${r%%[! ]*}"}   # trim start spaces (again)

	# Not needed: case $# in 1) i=${};; 0) ;; *) err .....
	case ${1+1} in 1)
		i=${i#"$1"}
		i=${i#"${i%%[! ]*}"}   # trim start spaces (again x2) just in case
	esac
	history_current_command=$1
	# echo-1l "$r"
}

history_current_command() {
	history_current_command__nosubshell "$@";
	echo-1l "$history_current_command"
}
