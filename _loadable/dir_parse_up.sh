#! /hint/sh

dir_parse_up() {
	local i || :

	case $# in
		0) echo ..;;
		1) case $1 in
			0) ;;
			[1-9])
				unset-unseted-i
				i=$1
				while [ 1 -lt "$i" ]; do
					printf %s ../
					i=$(( i - 1 ))
				done
				unset-seted-i
				echo ..
				return
			;;
			npm|node)
				unset-unseted-i
				i="$(npm root)" && \
				printf %s\\n "${i%/node_modules}"
				unset-seted-i
			;;
			git|g) git rev-parse --show-toplevel;;
			part|p) get-part-mounted .;;

			..) printf %s\\n ..;;
			*/*) printf %s\\n "${1%/*}";; # my favorite one: `cd.. /dir/to/file` will result in `cd /dir/to`

			*) printf %s\\n "\$1='$1', not matched" >&2; return 2;;
		esac;;
		*) case $1 in
			which)
				unset-unseted-i
				i=$(which -- "$2")
				printf %s\\n "${i%/*}"
				unset-seted-i
			;;
			*) printf %s\\n "\$1='$1', not matched" >&2; return 2;;
		esac;;
	esac

}