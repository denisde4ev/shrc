#!/hint/sh

( cd ~/B/_fetch && . "$(printf '%s\n' ./[!_.%]*[!%~] | shuf -n 1)" ) 
# isolate because of some () thurtt party fetch using `set -- [args]`

# [ $? = 105 ] && PS1-ash #105 is charCode of 'i' -> interactive shell
