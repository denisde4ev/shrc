#! /hint/sh

# pwd=_pwd_
_pwd__old_2026_02_02() {
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
		/^/' https:///'*) PWD=${PWD#/^/' https:///'}; PWD=/^/' https://'"${PWD#"${PWD%%[!/]*}"}";; # all good
		/^/' https://'*) ;; # all good
		/^/' https:'*)     PWD=/^/' https:/'${PWD#/^/' https:'};;
		/^/'%20https:'*)   PWD=/^/' https:/'${PWD#/^/'%20https:'};;
		/^/'https:'*)      PWD=/^/' https:/'${PWD#/^/'https:'};;
		/^/' https%3A'*)   PWD=/^/' https:/'${PWD#/^/' https%3A'};;
		/^/'%20https%3A'*) PWD=/^/' https:/'${PWD#/^/'%20https%3A'};;
		/^/'https%3A'*)    PWD=/^/' https:/'${PWD#/^/'https%3A'};;

		/^/' '[a-zA-Z]*''*)   PWD=/^/' https://'${PWD#/^/' '};;
		/^/'%20'[a-zA-Z]*''*) PWD=/^/' https://'${PWD#/^/'%20'};;
		/^/''[a-zA-Z]*''*)    PWD=/^/' https://'${PWD#/^/''};;
		*) false;;
	esac;; *) false; esac && {
		# pwd for GH url to print /tree/ instead of /raw/
		# but when file args specifyed:
		# if output is tty: print as /blob/ -- will most likely be for mouse click
		# else output as /raw/ (or leave as is) example: `pwd file1 | c` -- will most likely be for a symlink
		unset-unseted-i && {
			case $PWD in
				/\^/\ https://github.com/*/*/*/raw/*) false;; # expected to never have username/(idk, sub-username)/reponame/raw/....
				/\^/\ https://github.com/*/*/raw/*) true;;
			esac
		} && {
			case $# in
				0) i=tree;;
				*) # when has file args
					##
					## if [ -d "$@" ] # TODO: this code needs to be inside iteration over aguments...
					##
					{
						case $# in
							1)
								if [ -d "$1" ]; then
									i=tree
								else
									false
								fi
							;;
							*) false;;
						esac
					} || {
						if [ -t 1 ]; then
							i=blob
						else
							# i=raw # expected to not need change
							false
						fi
					}
				;;
			esac
		} && {
			PWD=${PWD#/\^/\ https://github.com/}
			( set -x ; : PWD1 = "$PWD" );
			i="${PWD%"${PWD#*/*/}"}/${i}"
			( set -x ; : i = "$i" );
			PWD=${PWD#"${i%/*}/raw/"}
			( set -x ; : PWD2 = "$PWD" );
			PWD="${i}/${PWD#}"
			( set -x ; : PWD3 = "$PWD" );
			unset-seted-i
			# TODO
		} || :
	}
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
