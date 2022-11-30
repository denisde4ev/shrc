
history_current_command() {
	#	unset-unseted-i # unset-unseted-i # DO NOT, or will UNEST `I` IN EVERY LINE
	local i || :

	#i=$(
	#	set -fue
	#	IFS=''
	#	history | {
	#		unset r
	#		while read -r i; do r=$i; done
	#		puts "$r"
	#	}
	#) || return
	i=$(history | tail -n 1) # seems to be faster for mine conf: `HISTSIZE=500000;HISTFILESIZE=1000000`

	# handle format s/^ *[0-9]* *//
	i=${i#"${i%%[! ]*}"}   # trim start spaces
	i=${i#"${i%%[!0-9]*}"} # trim start digits
	i=${i#"${i%%[! ]*}"}   # trim start spaces (again)

	# Not needed: case $# in 1) i=${};; 0) ;; *) throw err .....
	i=${i#"$1"}

	puts "$i"
}
