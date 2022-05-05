#! /hint/bash

command_not_found_handle() {
	: ::: command_not_found_handle "$@" ::: :
	# consider: '2>/dev/null' to be quiet on xtrace shell
	local comm _comm _arg exi; comm="$1"
	# _comm _arg i  = temp vars
	# exi  = matched and executed command exit code

	goto_continue {{
	case $comm in

	which)
		_arg=$(command -v -- "$1") || break
		case $_arg in */*)
			puts "$_arg"
			exi=$?
		esac
		;;

	*"#")
		${shell_is_interactive-break} # TODO
		_arg=$(history_current_command) && shift $# || break

		# note/(unfixable bug):
		# this can be miss matched pretty easily
		# for example: `: 'echo# '; echo# 1`
		# after `: 'echo#'` will output:
		#   actual: '; echo# 1"
		#   wanted: 1
		#
		# however because I want to use something like: `set-x echo# 1`, I will keep it like this
		# it is not easy to do this miss match exept on purpose

		case $_arg in *"$comm "*) ;; *)
			puts "command_not_found_handle err: _arg='$_arg' is not in *'$comm '*" >&2
			exi=127
			break
		esac
		_arg=${_arg#*"$comm "}
		_arg=${_arg#"#"}
		## NOTE: do not give me _comm=(some alias not expecting args) there is no point in it,
		# just leave the default shell syntax error
		eval "${comm%"#"}"' "$_arg"'
		exi=$?
		;;

	-[A-Z]*)
		case $comm in -*[!A-Za-z]*) break; esac # must have only letters
		trizen "$@"
		exi=$?
		;;

	*.which)
		_comm=${1%.which}; shift
		com-which -c "$ $_comm" "$@"
		exi=$?
		;;


	@*)
		# YN_confirm Yes "do you want to run: ssh ${1#@} \$@" || break
		_arg=${1#@}; shift
		ssh "$_arg" "$@"
		exi=$?
		;;

	esac

	${exi+break}
	
	case $comm in
		*.pwd)     shift; _comm=${comm%.pwd};     set -- "$@" "$PWD";;
		*.frompwd) shift; _comm=${comm%.frompwd}; set -- "$PWD" "$@";;
		*..)       shift; _comm=${comm%..}; _arg=${1%/*}; shift; set -- "$_arg" "$@";;
		*) break;;
	esac

	case $(command -v $_comm) in
		*/*) "$_comm" "$@";;
		[a-zA-Z_@]*) eval "$_comm"' "$@"';;
		*) "$_comm" "$@";;
	esac
	exi=$?

	
	goto_break }}


	case ${exi+x} in '')
		printf %s\\n "${0##*/}: $comm: command not found" >&2
		return 127
	esac

	eval "unset comm _comm _arg i; return '$exi'"
}
