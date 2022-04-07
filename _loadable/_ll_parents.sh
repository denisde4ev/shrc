#! /hint/sh

export PATHSEP=${PATHSEP:-/}

# ll.parents='_ll_parents	'
_ll_parents() {
	i{
	i=${1-$PWD}
	while
		ll -d -- "${i:-/}"
		case $i in */*) ;; *) false;; esac
	do
		i=${i%["$PATHSEP"]*}
	done
	}i
}

# this could be moved to separate command?
