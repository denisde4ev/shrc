
# pwd=_pwd_
_pwd_() {
	case $1 in
		-z) shift; fori{{ printf %s\\0 "$PWD/$i"; }};;
		''|-*|-[LP]) \pwd;;
		*) fori{{ echo-1l "$PWD/$i"; }};;
	esac
}
