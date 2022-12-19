#! /hint/sh

export PATHSEP=${PATHSEP:-/}

# ll.parents='_ll_parents	'
_ll_parents() {
	unset-unseted-i
	i=${1-$PWD}
	while
		ll -d -- "${i:-/}"
		case $i in */*) ;; *) false;; esac
	do
		i=${i%["$PATHSEP"]*}
	done
	unset-seted-i
}

# this could be moved to separate command?
