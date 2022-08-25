#! /hint/ash
${shell_is_interactive-return}

# NOTE: this file is symlinked from .ash to .bash version,
# so keep syntax compatible with ash!

# TODO: when starting to rewrite this file:
# PS1 depends on vars:
# 1. $0 if login -> colorize brackets
# 2. SHLVL -> underline the @ or $
# 3. SSH_CLIENT -> if defined (idk.. todo: think of something) (for now not added)
#





















case $PS4 in *'$('*) ;; *)
	export PS4='#$?+  '
esac

case ${BASH_VERSION+x} in x) . ~/B/%__history-append.bash; esac
case ${0##*/} in -*) PS1-x; return; esac

case $PS1 in
	*'$('*) :;;
	*/'\w \$ '|\\*) PS1=$'\\[\E[36m\\]\\W\\[\E(B\E[m\\] $( ( IFS=\\| eval "o=\\"\\\\${PIPESTATUS[*]}\\""; [[ $o = 0*(\\|0) ]] && echo "\\$" || echo "\\[\E[31m\\]$o\\[\E(B\E[m\\]" ) 2>&- )${i+\!} ';;
	*) false
esac && return


case ${BASH_VERSION+x} in x)
	. ~/B/%__history-append.bash
	case $PS1 in \[*)
		PS1=$'[\001\E[33m\002\\u\001\E(B\E[m\002@\\h \001\E[36m\002${PWD_gitrepodir:-\\W}\001\E(B\E[m\002]$( ( IFS=\\| eval "o=\\"\\\\${PIPESTATUS[*]}\\""; [[ $o = 0*(\\|0) ]] && echo "\\$" || echo "\001\E[31m\002$o\001\E(B\E[m\002" ) 2>&- )${i+"!"} ';
		return
	esac
esac



#### not used: PS2='\[\e[9m\]\[\e[100m\] \[\e[m\]'



case ${tput_red+x} in '') . ~/B/__define_colors; esac

# note: \1 is \[ , \] is \2
_ps1_r=$'\001'${tput_red:?}$'\002'
_ps1_b=$'\001'${tput_cyan:?}$'\002'
_ps1_w=$'\001'${tput_reset:?}$'\002'
_ps1_y=$'\001'${tput_yellow:?}$'\002'
_ps1_u=$'\001'${tput_underline:?}$'\002'
_ps1_e=$'\033'
# [[[ $PS1 in (\\s*) ]]] && PS1='[\u@\h \W]\$ '



# TODO: this is skiped when upper retrun exits
case $SHLVL in
	2) PS1=${PS1/"@"/"${_ps1_u}${_ps1_e}@${_ps1_w}"} ;;
	3) PS1=${PS1/"\\\$"/"${_ps1_u}\\\$${_ps1_w}"};;
esac

PS1=${PS1/"\\u"/"$_ps1_y\\u${_ps1_w}"} # color user in yellow

PS1=${PS1/"\\W"/"${_ps1_b}\\W${_ps1_w}"} # color full path in blue
PS1=${PS1/"\\w"/"${_ps1_b}\\w${_ps1_w}"} # color path in blue


case ${PIPESTATUS:+x} in # if bash has PIPESTATUS use it to cocat all from last piped commands
	x)
		PS1=${PS1/"\\$"/'$( ( IFS=\| eval "o=\"\\${PIPESTATUS[*]}\""; [[ $o = 0*(\|0) ]] && echo "\$" || echo "'"${_ps1_r}\$o${_ps1_w}\""' ) 2>&- )'}
		# and not print when xtrace, so dont use:
		#PS1=${PS1/'\$'/'$(   IFS=\| eval "o=\"\\${PIPESTATUS[*]}\""; [[ $o = 0*(\|0) ]] && echo "\$" || echo "'"${_ps1_r}\$o${_ps1_w}\""' )       '}
	;;
	*)
		PS1=${PS1/"\\$"/'$( ( (exit $?) &&  echo "\$" || echo "'"${_ps1_r}\$?${_ps1_w}\""' ) 2>&- )'}
	;;
esac


unset _ps1_r _ps1_b _ps1_w _ps1_y _ps1_u _ps1_e; return


_ps1_e=$(printf \\\33) # PS1=ps1_ dash
# warning it inlines user, hostname and uses ${PWD##*/}
ps1=$(
printf %s\\n "$PS1" | sed -Ee '
s%\\\[|\\\]%%g;
s%\\u%\${USER:=$(whoami)}%g;
s%\\h%${HOSTNAME:=$(hostname)}%g;
# s%\\[Ww]%\${PWD##*/}%g;
s%\\[Ww]%\$(o=$?;case "$PWD" in /)echo /;;~)echo "~";;*)"${PWD##*/}";;esac;exit $o)%g;
s%\\e%$_ps1_e%g;
s%\(\(o\)\)%[ "$o" -ne 0 ]%;
'
)
