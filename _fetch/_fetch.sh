#! /hint/sh
${shell_is_interactive-return}

( cd "$B"/_fetch && . "$(printf '%s\n' ./[!_.%]*[!%~] | shuf -n 1)" >&2 0<&- )
