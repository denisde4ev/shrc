
history_current_command() {
		local i
		i=$(
			set -fu; IFS=;
			history | {
				r=''
				while read -r i; do r=$i; done
				echo-1l "$r"
			}
		)

		# handle format s/^ *[0-9]* *//
		i=${i#"${i%%[! ]*}"}   # trim start spaces
		i=${i#"${i%%[!0-9]*}"} # trim start digits
		i=${i#"${i%%[! ]*}"}   # trim start spaces (again)

		# Not needed: case $# in 1) i=${};; 0) ;; *) err .....
		i=${i#"$1"}
		# i=${i#"${i%%[! ]*}"}   # trim start spaces (again x2) just in case

		echo-1l "$i"
}
