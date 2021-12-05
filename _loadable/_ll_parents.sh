#!/ /hint/sh

_ll_parents() {
	i=${1-$PWD}
	while
		ll -d -- "$i";
		case $i in */*) ;; *) false;; esac
	do
		i=${i%["${PATHSEP:-/}"]*}
	done
}
