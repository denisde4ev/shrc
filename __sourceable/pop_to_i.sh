#! /hint/sh
{
	unset i;
	i=$#;
	while case $i in 0|1) false; esac; do # while i is not 0|1
		set -- "$@" "$1"
		shift
		i=$(( i - 1 ))
	done
	i=$1
	shift
}
