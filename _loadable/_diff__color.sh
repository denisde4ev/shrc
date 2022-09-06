#!/bin/sh

_diff__color() {
	# --color[=WHEN]
	#        color output; WHEN is 'never', 'always', or 'auto'; plain --color means --color='auto'

	local NEW_LINE=$NEW_LINE       ; NEW_LINE=${NEW_LINE-$'
'}
	local _diff__color__arg_color  || unset _diff__color__arg_color
	local _diff__color__unsuported || unset _diff__color__unsuported
	local _diff__color__arg_mode   ;  _diff__color__arg_mode='def'

	i{
		i=$#;
		while case $i in 0) false; esac; do
			case $1 in
				--color)  _diff__color__arg_color=auto;;
				--color=*) _diff__color__arg_color=${1#"--color="};;
				*)
					case $1 in
						-c|-C*|--context|--context=*) _diff__color__arg_mode=context ;;
						-u|-U*|--unified|--unified=*) _diff__color__arg_mode=unified ;;
						-e|--ed)                      _diff__color__arg_mode=ed      ;;
						-n|--rcs)                     _diff__color__arg_mode=rcs     ;;
						-y|--side-by-side)
							_diff__color__unsuported="_diff__color (wrapper for diff --color): does not support '$1'->'output in two columns' format"
						;;

						--LTYPE-line-format=*|--line-format=*|--GTYPE-group-format=*)
							_diff__color__unsuported="_diff__color (wrapper for diff --color): does not support custom format"
						;;

						*) ;;
					esac
					set -- "$@" "$1"
				;;
			esac
			i=$(( i - 1 ))
			shift
		done
	}i

	case _diff__color__arg_mode in
		rcs) _diff__color__unsuported="_diff__color (wrapper for diff --color): does not support rcs format";;
		ed)  _diff__color__unsuported="_diff__color (wrapper for diff --color): does not support ed format" ;;
	esac

	case ${_diff__color__unsuported+x} in
		x)
			case ${_diff__color__unsuported} in
				'') ;; # no message to print, but still unsuported
				*) printf %s\\n "${_diff__color__unsuported}" >&2;;
			esac
			diff --color="$_diff__color__arg_color" "$@"
			return
		;;
	esac


	case ${_diff__color__arg_color-never} in
		auto)
			if [ -t 1 ]; then 
				_diff__color__arg_color=always
			else
				_diff__color__arg_color=never
			fi
		;;
	esac

	case ${_diff__color__arg_color-never} in
		never) diff "$@"; return;;
		always)
			# colors: '\33['
			diff "$@" | {
				. "$B"/__define_colors || return
				case $_diff__color__arg_mode in
					def)     sed "s/^</$tput_red</; s/^>/$tput_green>/; s/\$/$tput_reset/;";;
					context) sed "s/^\!/$tput_yellow\!/; s/\$/$tput_reset/;";;
					unified) sed "s/^+/$tput_red+/; s/^-/$tput_green-/; s/^@/$tput_cyan@/;  s/\$/$tput_reset/;";; # TODO: first 2 lines are comments? TODO: is it? find in specs
					# rcs)     sed "....";;
					# ed )     sed "....";;
					*) cat;;
				esac
			}
		;;
		*) diff --color="$_diff__color__arg_color" "$@"; return;;
	esac
}

