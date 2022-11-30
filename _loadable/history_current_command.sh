
history_current_command() {
		local i

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

		# Not needed: case $# in 1) i=${};; 0) ;; *) err .....
		i=${i#"$1"}
		# i=${i#"${i%%[! ]*}"}   # trim start spaces (again x2) just in case

		puts "$i"
}
