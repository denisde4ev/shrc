#! /hint/sh

isnum() {
	case $@ in
		''|*[!0-9]*) false;;
		*) true;;
	esac
}
		# [!0]*) # if arg is positive num, todo fix?
			# cd "$(
				# i=${1:-1}
				# while [ 0 -lt "$i" ]; do
					# printf %s ../
					# i=$(( i - 1 ))
				# done
			# )"
			# return
		# ;;
