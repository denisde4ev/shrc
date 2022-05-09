#! /hint/sh

# pwd=_pwd_
_pwd_() {
	case $1 in
	--|[!-]*)
		unset-unseted-i
		for i; do
			puts "$PWD/$i"
		done
		unset-seted-i
		return
	;;
	--shell|--url|--url-encode)
		;;
	*)
		\pwd "$@"
		return
		;;
	esac

	puts >&2 unimplemented
	return 127

	# local opt_url opt_url_encode opt_shell
# 
	# while case $# in 0) false; esac; do
		# case $1 in
			# --url) opt_url='';;
			# --url-encode) opt_url_encode='';;
			# --shell) opt_shell='';;
			# --) shift; break;;
			# *) break;;
		# esac
		# shift
	# done
# 
	# case ${opt_url+u}:${opt_url_encode+ue}:${opt_shell+s} in
		# :ue:|u:ue:)
			# while case $# in 0) false; esac; do
			# 
			# printf file:
			# puts "$PWD/$1" \
			# | node.encodeURIComponent \
			# | sed 's@%2[Ff]@/@g; s/%0A/\n/g'
			# # do not encode just the "/"
			# # and new line is just new line
		# u::)
			# puts "file:$PWD/${2#./}"
			# ;;
		# ;;
		# --shell)
			# ###for i
			# ;;
		# 
	# esac
}
