#! /hint/zsh
${shell_is_interactive-return}

echo TODO "$B"/%bindkey.zsh
bindkey "\33[F" end-of-line
bindkey "\33[H" beginning-of-line
