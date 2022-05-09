#! /hint/bash

command_not_found_handle() {
	. ~/B/__sourceable/command_not_found_handle
}
return



#
#command_not_found_handle() {
#	: ::: command_not_found_handle "$@" ::: :
#	# consider: '2>/dev/null' to be quiet on xtrace shell
#
#	local comm _comm _arg exi; comm="$1"; shift
#	# _comm _arg i  = temp vars
#	# exi  = matched and executed command exit code
#
#	goto_continue {{
#	case $comm in
#
#	which)
#		_arg=$(command -v -- "$comm") || break
#		case $_arg in */*)
#			puts "$_arg"
#			exi=$?
#		esac
#		;;
#
#	*"#")
#		${shell_is_interactive-break}
#		_arg=$(history_current_command) || break
#
#		# note/(unfixable bug):
#		# this can be miss matched pretty easily
#		# for example: `: 'echo# '; echo# 1`
#		# after `: 'echo#'` will output:
#		#   actual: '; echo# 1"
#		#   wanted: 1
#		#
#		# however because I want to use something like: `set-x echo# 1`, I will keep it like this
#		# it is not easy to do this miss match exept on purpose
#		case $_arg in *"$comm "*) ;; *)
#			puts "command_not_found_handle err: _arg='$_arg' is not in *'$comm '*" >&2
#			exi=127
#			_arg=''
#		esac
#		case ${_arg:+x} in x)
#			_arg=${_arg#*"$comm "}
#			_arg=${_arg#"#"}
#			## NOTE: do not give me _comm=(some alias not expecting args) there is no point in it,
#			# just leave the default shell syntax error
#			eval " ${comm%"#"}"' "$_arg"'
#			exi=$?
#		esac
#		;;
#
#
#	*.which)
#		com-which -c "$ ${comm%.which}" "$@"
#		exi=$?
#		;;
#
#	*.c|*.copy|*.pipecopy)
#		eval " ${comm%.*}"' "$@" | clip_io'
#		exi=$?
#		;;
#
#	esac
#
#	goto_continue {{
#	case $comm in
#		*.topwd)   _comm=${comm%.*};                      set -- "$@" "$PWD";;
#		*.pwd)     _comm=${comm%.*};                      set -- "$PWD" "$@";;
#		*..)       _comm=${comm%..}; _arg=${1%/*}; shift; set -- "$_arg" "$@";;
#		*) break;;
#	esac
#
#	case $(command -v -- "$_comm") in
#		*/*) "$_comm" "$@";;
#		[a-zA-Z_@]*) eval " $_comm"' "$@"';;
#		*) "$_comm" "$@";;
#	esac
#	exi=$?
#	goto_break }}
#
#	goto_break }}
#
#	goto_continue {{
#	case $comm in
#	-[A-Z]*)
#		case $comm in -*[!A-Za-z]*) break; esac # must have only letters
#		trizen "$comm" "$@" # note: hardcoded preferred aur helper
#		exi=$?
#		;;
#
#	@*|root@*)
#		ssh "${comm#@}" "$@"
#		exi=$?
#		;;
#
#	song-*)
#		{
#			YN_confirm -S y "song: $comm does not exist, do you want to create it now?" || break
#			song_gen "${comm#"song-"}"
#			exi=$?
#			YN_confirm -S y "after song_gen: do you want to run $comm now?" || break
#		}  </dev/tty >/dev/tty 2>/dev/tty
#		"$comm" "$@"
#		exi=$?
#		;;
#	esac
#	goto_break }}
#
#
#
#
#	case ${exi+x} in '')
#		printf %s\\n "${0##*/}: $comm: command not found" >&2
#		exi=127
#	esac
#
#	eval "unset comm _comm _arg i; return '$exi'"
#}
#
