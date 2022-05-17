#! /hint/sh

case $# in
???*)
	eval "set -- $(seq "$#" | tac | sed 's/^/"\${/;  s/$/}" \\/; $ a;')"
	;;
*)
	reverse_args_first=''
	for reverse_args_i; do
		set -- "$reverse_args_i" ${reverse_args_first-"$@"}
		unset reverse_args_first
	done
	unset reverse_args_i reverse_args_first
esac
