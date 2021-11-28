#!/hint/bash

ui=$(tty)
[[ $ui != /dev/tty[0-9]* ]] &&
if [[ $DE || $WM ]];                                   then ui="${DE:+DE}${DE:+${WM:+/}}${WM:+WM}:      ${DE:+${WM:+$'\e[3D'}}$DE${DE:+${WM:+/}}$WM"
elif [[ $XDG_CURRENT_DESKTOP || $DESKTOP_SESSION ]];   then ui="DE:      ${XDG_CURRENT_DESKTOP:-}${XDG_CURRENT_DESKTOP:+${DESKTOP_SESSION:+, }}${DESKTOP_SESSION:-}"
elif [[ -r ~/.xinitrc || -r ~/.xsession ]];            then
	uiexec=
	for i in $(sed -ne 's/^exec //p' ~/.xinitrcs ~/.xsession 2>/dev/null); do
		[[ $(pidof -- "$uiexec") ]] && uiexec+=" $(basename -- "$i")"
	done
	[[ $uiexec != *( ) ]] && ui="WM:      ${uiexec# }"
fi || ui="TTY:     ${ui#/dev/tty}"




prompt-printf()         { sleep .1; printf %s "${@@P}"; }
newline-prompt-printf() { sleep .1; printf \\n%s "${@@P}"; }
newline-printf()        { sleep .1; printf \\n%s "$@"; }

printf '




\e[5A'

prompt-printf '\e[34m'
prompt-printf '      .    '
newline-printf '     / \   '
newline-printf '    / _ \  '
newline-printf '   / / - \ '
newline-printf '  /`     `\'
prompt-printf '\r\e[4A\e[m'

prompt-printf '\e[14C\e[33m\u\e[m@\h  \e[36m\w\e[m'
newline-prompt-printf '\e[14COS:      ArcoLinuxB-Plasma'
newline-prompt-printf '\e[14CKERNEL:  $(uname -r)'
newline-prompt-printf '\e[14CSHELL:   $(basename -- ${0:-$SHELL})'
newline-prompt-printf '\e[14C$ui'
echo

