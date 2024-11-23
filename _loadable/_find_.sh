
# NOTE: this/those fn are only support \n not -0 null output
# https://unix.stackexchange.com/questions/4847/make-find-show-slash-after-directories

case ${os_gnu+x} in
x)
	_find_() {
	unset-unseted-i
		if . "$B"/__sourceable/pop_to_i.auto; then # copy:21699
			case $i in -0) \find "$@" -0; eval "unset-seted-i; return $?"; esac
			set -- "$@" "$i"
			unset-seted-i
		fi

		# \find "$@" \( -type d -printf %p/\\n , ! -type d -print \)
		\find "$@" \( -type d -printf %p/\\n -or -print \)
	}
	;;
*)

	# calling sh many times...:
	#_find_() {
	#	#\find "$@" \( -type d -exec sh -c 'printf %s/\\n "$@"' -s -- {} + -or -print \) # does seems to work for busybox
	#	\find "$@" \( -type d -exec sh -c 'printf "%s/\n" "$0"' {} \; -or -print \)
	#}

	_find_() {
		unset-unseted-i
		if . "$B"/__sourceable/pop_to_i.auto; then # copy:21699
			case $i in -0) \find "$@" -0; eval "unset-seted-i; return $?"; esac
			set -- "$@" "$i"
			unset-seted-i
		fi

		\find "$@" | {
			unset-unseted-i
			while IFS= read -r i; do
				if [ -d "$i" ]; then
					printf %s\\n "$i/"
				else 
					printf %s\\n "$i"
				fi
			done
			unset-seted-i
		}
	}
esac


