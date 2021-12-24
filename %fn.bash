#! /hint/bash


arg() {
	[[ -t 1 && -t 2 ]] && { local IFS= i=$*; echo -n "$#:${#i} "; } >&2
	echo "${@@Q}"
}

