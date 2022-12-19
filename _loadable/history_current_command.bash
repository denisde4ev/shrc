
history_current_command() {
	# unset-unseted-i # DO NOT, or will UNEST `I` IN EVERY LINE
	local i


	i=$(history 1)

	# REQUIRES `shopt -s extglob`

	i=${i##*(\ )+([0-9])*([\ ])}
	# Not needed: case $# in 1) i=${};; 0) ;; *) throw err .....
	i=${i#"$1"}

	printf %s\\n "$i"
}
