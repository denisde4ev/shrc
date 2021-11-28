#!/bin/sh
ui=$(tty)
case $ui in /dev/tty*) false;esac &&
if [ -n "$DE" -o -n "$WM" ];                                   then ui="${DE:+DE}${DE:+${WM:+/}}${WM:+WM}:      ${DE:+${WM:+$'\e[3D'}}$DE${DE:+${WM:+/}}$WM"
elif [[ $XDG_CURRENT_DESKTOP || $DESKTOP_SESSION ]];   then ui="DE:      ${XDG_CURRENT_DESKTOP:-}${XDG_CURRENT_DESKTOP:+${DESKTOP_SESSION:+, }}${DESKTOP_SESSION:-}"
elif [[ -r ~/.xinitrc || -r ~/.xsession ]];            then
	uiexec=
	for i in $(sed -ne 's/^exec //p' ~/.xinitrc ~/.xsession 2>/dev/null); do
		[[ $(pidof -- "$uiexec") ]] && uiexec+="$(basename -- "$i") "
	done
	[[ ${uiexec% } ]] && ui="WM:      ${uiexec% }"
fi || ui="TTY:     ${ui#/dev/}${SSH_TTY:+, ssh}"

# [[ $os ]] || os=$(sed -ne 's/PRETTY_NAME=//p' "$PREFIX/etc/os-release" || echo "$MACHTYPE"); os=${os#[\'\"]}; os=${os%[\'\"]}
[[ $os ]] || {
	. "$PREFIX/etc/os-release"
	os=${PRETTY_NAME:-${NAME:-$MACHTYPE}}
}

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
 c=$(( ${RANDOM:-$(\dd if=/dev/random | tr -dc 0-9 | head -c 1)} % 10 ));l=11
;;
# Space Invaders
esac

# printf '\e[3'"$c"'m%s\e[m\n\e[5A' "$a"
for i in "${!c[@]}"; do
	printf "\\e[${c[i]:+3}${c[i]}"'m%s' "${a[i]}"
done
printf '\e[m\n\e[5A'

p='\e[3'"$((EUID==0?1:3))"'m\u\e[m@\h \e[3'"$c"'m\w\e[m'
b=;for i in /sys/class/power_supply/{{BAT,axp288_fuel_gauge,CMB}*,battery}; do [[ -r $i/capacity ]] || continue; b+="${b:+, }$(< "$i/capacity")% $(< "$i/status")"; done # 1 line detect battery level
printf "\\e[${l:-11}C%s\\n" \
	"${p@P}" \
	"OS:      $os" \
	"KERNEL:  $(uname -r)" \
	"${b:+BATTERY: }${b:-SHELL:   $(basename -- ${SHELL:-$0})}" \
	"$ui" \



