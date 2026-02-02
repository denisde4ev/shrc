#!/bin/sh



_rl_sub() {
	#READLINE_LINE='# WAIT...'
	#[ -f /tmp/rl.$1 ] || 
	#mkfifo /tmp/rl.$1
	if [ -t 0 ]; then
		case ${READLINE_LINE:+x} in x)
			eval "$READLINE_LINE" > /tmp/rl.$1
		esac
	else
		#cat > /tmp/rl.$1 & # when using (fifo/pipe) file
		cat > /tmp/rl.$1
	fi
}

_rl_set() {
	eval "$READLINE_LINE" > /tmp/rl.$1;
}

_rl_get() {
	READLINE_LINE=$(cat /tmp/rl.$1)
	READLINE_POINT=${#READLINE_LINE}
}


_rl_yank() {
	local insert
	insert=$(cat /tmp/rl.$1)
	READLINE_LINE="${READLINE_LINE:0:READLINE_POINT}${insert}${READLINE_LINE:READLINE_POINT}"
	READLINE_POINT=$(( READLINE_POINT + ${#insert} ))
}



_rl_clenup() { # TODO: run this on exit
	\rm -f /tmp/rl.$1 >/dev/null
}

alias rl='_rl_sub $$; _rl_get $$'

bind -x '"\C-x\C-j": _rl_set $$'
#bind -x '"\C-x\C-b": _rl_get $$'
bind -x '"\C-x\C-y": _rl_yank $$'

