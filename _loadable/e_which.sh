#! /hint/sh
e_which() { (
	IFS=$'\n'
	set -f
	exec "${EDITOR:?}" $(which "$@")
) }
