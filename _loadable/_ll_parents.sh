#!/ /hint/sh

# ll.parents='_ll_parents	'
_ll_parents() {
	i=${1-$PWD}
	while
		ll -d -- "$i";
		case $i in */*) ;; *) false;; esac
	do
		i=${i%["${PATHSEP:-/}"]*}
	done
}

# this could be moved to separate command?
