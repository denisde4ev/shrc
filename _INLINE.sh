#!/bin/bash

# ifs=$IFS
s=*([$' \t\n']) # for mine trimming - ecvivalent to /\s*/ 
IFS=



read_fn () {
	local fn # function name
	fn=${1%%$s'()'*}
	fn=${fn##$s}
	# get fn name, ecvivalen to / *(?<fn>.+?) *\(\)/
	[[ $fn = +([a-z_]) ]] || return 1 # validate name
	echo "$1"
	while read -r i; do
		echo "$i"
		[[ $i = *( )"$fn "* ]] && return
	done
	return 1
}


INLINE () {
	local fn

	while read -r i; do
		if [[ $i = *' ##INLINE##' ]]; then
			fn=$(read_fn "$i")
			#### ...............
			
		
}

cat | INLINE
# usless cat
# /ᐠ｡ꞈ｡ᐟ\
