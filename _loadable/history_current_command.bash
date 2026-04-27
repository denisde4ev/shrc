
function history_current_command_set() {
	# unset-unseted-i # DO NOT, or will UNEST `I` IN EVERY LINE
	#local i


	history_current_command=$(history 1)

	# REQUIRES `shopt -s extglob`

	history_current_command=${history_current_command##*(\ )+([0-9])*([\ ])}
	# Not needed: case $# in 1) i=${};; 0) ;; *) throw err .....
	history_current_command=${history_current_command#"$1"}
}


function history_current_command() {
	history_current_command_set
	printf %s\\n "$history_current_command"
}
