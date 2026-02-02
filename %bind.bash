#! /hint/bash
${shell_is_interactive-return}

# Shift+Tab: alias-expand-line
bind  '"\e[Z": alias-expand-line'
 #### 2>&- || return # 'no bind cmd', we do not have bind in this bash ?

# bind '"\b": '


# Shift + F11 = decrease brightness, Shift+F12 increase brightness  # also moves cursor to 6 lines up (\n + brightnessctl expected to be 5 lines)
bind '"\e[23;2~": "brightnessctl s 1%- && printf \\\\e\\\[6A \n"'
# bind '"\e[23;2~": "$(brightnessctl s 1%- && printf \\\\e\\\[6A \n)"'
bind '"\e[24;2~": "brightnessctl s 1%+ && printf \\\\e\\\[6A \n"'
# bind '"\e[24;2~": "$(brightnessctl s 1%+ && printf \\\\e\\\[6A \n)"'


# Ctrl + T = search forward (Ctrl+R is backwords)
# default for Ctrl+T is "transpose-chars" from bash
# bind '"\C-t": forward-search-history'

## Shift + Enter = new line without execution
#bind '"\eOM": "\026\n"'


# Ctrl + BackSpace / "OldBackspace" = remove left word
# bind '"\b": unix-word-rubout'
# bind '"\b": backward-kill-word'
bind '"\b": shell-backward-kill-word'


# disable Meta+S it is overwrited by OS but sometimes does't work
bind '"\030@ss": "_"'


## # media player controls fallback: (never tested)
## bind '"\EO1P": ##pause/resume'
## bind '"\EO3Q": ##rext'
## bind '"\EO3R": ##prev'




# ai generated, no idea how this works, but it works 
_bashreadline_run() {
	local line=$READLINE_LINE

	# If line begins with RUN␣ then execute it
	case $line in *"#run")
		#local cmd="${line#RUN }"
		local cmd="${line}"
		local out

		# Capture output (ignore errors)
		out="$(eval "$cmd" 2>/dev/null)"

		# Replace entire line with output
		READLINE_LINE="$out"
		READLINE_POINT=${#READLINE_LINE}
		return
	esac

	return 1
}


_bashreadline_typed_shift_enter() {
	_bashreadline_run && return 0

	# Otherwise: insert a real newline
	READLINE_LINE="${READLINE_LINE:0:$READLINE_POINT}"$'\n'"${READLINE_LINE:$READLINE_POINT}"
	((READLINE_POINT++))
}
bind -x '"\eOM": _bashreadline_typed_shift_enter'



#{
	# does not work, please dont redefine enter key, as breaks everything
	# history arrows + history command + history saving + prompt updating

	_bashreadline_typed_shiftenter() {
		_bashreadline_run && return 0

		builtin eval "$READLINE_LINE"
	}
	#bind  '"\C-x\C-m":    "echo m"'
	#bind  '"\C-x\eOM":    "echo om1"'
	#bind  '"\C-x\e[O2M":  "echo om"'
	#bind  '"\C-x\C-j":    "echo j"'
	bind -x '"\C-x\C-m": _bashreadline_typed_shiftenter'
#}


