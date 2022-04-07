
# pwd=_pwd_
_pwd_() {
	case ${1-"-"} in
		--url) puts "file:/$PWD/$i";;
		## never used:
		## --url-encode)
		## 	printf file:
		## 	puts "$PWD/$i" \
		## 	| node.encodeURIComponent \
		## 	| sed 's@%2[Ff]@/@g; s/%0A/\n/g'
		## 	# do not encode just the "/"
		## 	# and new line is just new line
		## ;;
		''|-*|-[LP]) \pwd "$@";;
		*) i{; fori{{ puts "$PWD/$i"; }}; }i;;
	esac
}
