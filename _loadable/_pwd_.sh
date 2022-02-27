
# pwd=_pwd_
_pwd_() {
	case ${1-"-"} in
		''|-*|-[LP]) \pwd "$@";;
		*) i{; fori{{ puts "$PWD/$i"; }}; }i;;
	esac
}
