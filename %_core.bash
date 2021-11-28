#!/hint/bash


	# '[[[=case' \
	# ']]]=:;;*)false;esac' \
	# '{{=do' \
	# '}}=done' \
alias \
	one_and='[[ $? -eq 0 ]]&&' \
	one_or='[[ $? -eq 0 ]]||' \

alias \
	_every='(for i in "${PIPESTATUS[@]}"; do (( ! i )) || exit "$i"; done)'
	every_and='_every &&' and=every_and\
	 every_or='_every ||' or=every_or\
	 \
	_some='(for i in "${PIPESTATUS[@]}"; do (( ! i )) && exit "$i"; done)'
	some_and='_some &&' \
	some_or='_some ||' \


	# every_and='(IFS=: eval "o=:\${PIPESTATUS[*]}:"; [[ $o = 0*(\|0) ]])&&' \
	# some_and='[[ :$o: = 0*(\|0) ]]&&' \
		# or='[[ $o = 0*(\|0) ]]||' \
	# every_or='(IFS=: eval "o=:\${PIPESTATUS[*]}:"; [[ $o = 0*(\|0) ]])||' \