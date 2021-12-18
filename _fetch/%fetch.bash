#!/bin/bash
set -eu

${os+:} . "${PREFIX-}"/etc/os-release # you can use: `( os=artix3 . ./<this_script>.sh )`
os=${os-${PRETTY_NAME:-${NAME:-$MACHTYPE}}}

c=4
case ${os,,} in
arch*)a=\
'     .    
    / \   
   / _ \  
  / / \ \ 
 /`     `\';;
arco*)a=\
'     .    
    / \   
   / . \  
  / / _ \ 
 /`     `\';;
artix)a=\
"     .    
    / \\   
   /.  \\  
  /   * \\ 
 /   '   \\";c=6;;
artix2)a=\
"     .    
    / \\   
   /'. \\  
  /   .'\\ 
 /   '   \\";c=6;;
artix3*)a=\
'
    /\   
   /  \  
  / 🎨 \ 
 /      \';c=6;l=9;;
alpine*)a=(
'
   /\
  /  \' ' /\' '
 /' '◁' '   \' '  \
'
);
c=(4 '' 4 '' 4 '' 4 4 '');l=12;;
android*)a=\
'
 ╲_____╱ 
 ╱ . . ╲ 
▕       ▏
 ▔▔▔▔▔▔▔ ';c=2;l=9;;
kiss*)a=\
'
 +----+
 | |/ |
 | |\ |
 +----+';c=1;l=8;;
manjaro*)a=\
'
 █████ ██
 ██ ▄▄ ██
 ██ ██ ██
 ██ ██ ██';c=2;l=10;;
*)a=\
'░░▀▄░░░▄▀░░
░▄█▀███▀█▄░
█▀███████▀█
█░█▀▀▀▀▀█░█
░░░▀▀░▀▀░░░';
 c=${RANDOM:2:1};l=11
;;
# Space Invaders
esac

for i in "${!c[@]}"; do
	printf "\\e[${c[i]:+3}${c[i]}"'m%s' "${a[i]}"
done
printf '\e[m\n\e[5A'



ui=$(tty)
case $ui in /dev/tty*) ! :; esac && \
if [[ ${DE-}${WM-} ]]; then ui="${DE:+DE}${DE:+${WM:+/}}${WM:+WM}:      ${DE:+${WM:+$'\e[3D'}}$DE${DE:+${WM:+/}}$WM"
elif [[ ${XDG_CURRENT_DESKTOP-}${DESKTOP_SESSION-} ]];   then ui="DE:      ${XDG_CURRENT_DESKTOP:-}${XDG_CURRENT_DESKTOP:+${DESKTOP_SESSION:+, }}${DESKTOP_SESSION:-}"
elif [[ -r ~/.xinitrc || -r ~/.xsession || ~/.config/xorg-xinit/xinitrc ]]; then
	uiexec=
	for i in $(sed -ne 's/^exec //p' ~/.xinitrc ~/.xsession ~/.config/xorg-xinit/xinitrc 2>/dev/null); do
		[[ $(pidof -- "$uiexec") ]] && uiexec+="${i##*/} "
	done
	[[ ${uiexec% } ]] && ui="WM:      ${uiexec% }"
else ! :
fi || \
ui="TTY:     ${ui#/dev/}${SSH_TTY+, ssh}"


p='\e[3'"$((EUID==0?1:3))"'m\u\e[m@\h \e[3'"$c"'m\w\e[m'

b=;
for i in /sys/class/power_supply/{{BAT,axp288_fuel_gauge,CMB}*,battery}; do
[[ -r $i/capacity ]] && b+="${b:+, }$(< "$i/capacity")% $(< "$i/status")"
done

printf "\\e[${l:-11}C%s\\n" \
	"${p@P}" \
	"OS:      $os" \
	"KERNEL:  $(uname -r)" \
	"${b:+BATTERY: }${b:-SHELL:   $(basename -- "${SHELL:-$0}")}" \
	"$ui" \
;
