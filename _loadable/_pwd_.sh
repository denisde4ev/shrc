#! /hint/sh

# pwd=_pwd_
_pwd_() {
	# case $1 in -) ;; *)

	# known dirs:
	# ' https:'
	# |        || ' '         | '%20'         | ''           |
	# |--------||-------------|---------------|--------------|
	# | ':'    || ' https:'   | '%20https:'   | 'https:'     |
	# | '%3A'  || ' https%3A' | '%20https%3A' | 'https%3A'   |
	# 
	# ' (domain)' '%20(domain)' '(domain)'
	# 
	# # (for now no "http" with no "s", yuppy less pattern matching)
	case $PWD in /^/*) case $PWD in
		/^/' https:'*)     PWD=/^/' https:/'${PWD#/^/' https:'};;
		/^/'%20https:'*)   PWD=/^/' https:/'${PWD#/^/'%20https:'};;
		/^/'https:'*)      PWD=/^/' https:/'${PWD#/^/'https:'};;
		/^/' https%3A'*)   PWD=/^/' https:/'${PWD#/^/' https%3A'};;
		/^/'%20https%3A'*) PWD=/^/' https:/'${PWD#/^/'%20https%3A'};;
		/^/'https%3A'*)    PWD=/^/' https:/'${PWD#/^/'https%3A'};;

		/^/' '[a-zA-Z]*''*)   PWD=/^/' https://'${PWD#/^/' '};;
		/^/'%20'[a-zA-Z]*''*) PWD=/^/' https://'${PWD#/^/'%20'};;
		/^/''[a-zA-Z]*''*)    PWD=/^/' https://'${PWD#/^/''};;
	esac; esac
	#esac
	
	case $1 in
	'')
		printf %s\\n "$PWD" | grep --color /
		;;
	-*)
		\pwd "$@"
		;;
	*)
		unset-unseted-i
		for i; do
			printf %s\\n "$PWD/$i"
		done
		unset-seted-i
	esac
}
