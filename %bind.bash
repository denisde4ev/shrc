#!/ /hint/bash


# Shift+Tab: alias-expand-line
bind  '"\e[Z": alias-expand-line' \
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

# Shift + Enter = new line without execution
bind '"\eOM": "\026\n"'


# Ctrl + BackSpace / "OldBackspace" = remove left word
# bind '"\b": unix-word-rubout'
# bind '"\b": backward-kill-word'
bind '"\b": shell-backward-kill-word'


# disable Meta+S it is overwrited by OS but sometimes does't work
bind '"\030@ss": "_"'
