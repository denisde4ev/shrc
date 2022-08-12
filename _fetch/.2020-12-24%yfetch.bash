#!/bin/bash
# (

ui=$(tty) 
[[ $ui != /dev/tty* ]] &&
ui="TTY:     ${ui#/dev/tty}${SSH_TTY:+, ssh}" ||
if [[ $DE || $WM ]];                                   then ui="${DE:+DE}${DE:+${WM:+/}}${WM:+WM}:      ${DE:+${WM:+$'\e[3D'}}$DE${DE:+${WM:+/}}$WM"
elif [[ $XDG_CURRENT_DESKTOP || $DESKTOP_SESSION ]];   then ui="DE:      ${XDG_CURRENT_DESKTOP:-}${XDG_CURRENT_DESKTOP:+${DESKTOP_SESSION:+, }}${DESKTOP_SESSION:-}"
elif [[ -r ~/.xinitrc || -r ~/.xsession ]];            then
	uiexec=
	for i in $(sed -ne 's/^exec //p' ~/.xinitrc ~/.xsession 2>/dev/null); do
		[[ $(pidof -- "$uiexec") ]] && uiexec+="$(basename -- "$i") "
	done
	[[ ${uiexec% } ]] && ui="WM:      ${uiexec% }"
fi || 
:

# [[ $os ]] || os=$(sed -ne 's/PRETTY_NAME=//p' "$PREFIX/etc/os-release" || echo "$MACHTYPE"); os=${os#[\'\"]}; os=${os%[\'\"]}
[[ ! $os && -r $PREFIX/etc/os-release ]] && {
	. "$PREFIX/etc/os-release"
	os=${PRETTY_NAME:-$MACHTYPE}
}
#" FFFIX (micro)

c=4
case ${os,,} in
arch*)a=\
'    .    
   / \   
  / _ \  
 / / \ \ 
/`     `\';;
arco*)a=\
'    .    
   / \   
  / . \  
 / / _ \ 
/`     `\';;


artix1)a=\
"    .    
   / \\   
  /.  \\  
 /   * \\ 
/   '   \\";c=6;;
artix2)a=\
"    .    
   / \\   
  /'. \\  
 /   .'\\ 
/   '   \\";c=6;;



artix*)a=\
'        
   /\   
  /  \  
 / 🎨 \ 
/      \';c=6;l=9;;
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
+----+';c=1;l=7;;
manjaro*)a=\
'
█████ ██
██ ▄▄ ██
██ ██ ██
██ ██ ██';c=2;l=9;;

*)a=\
'░░▀▄░░░▄▀░░
░▄█▀███▀█▄░
█▀███████▀█
█░█▀▀▀▀▀█░█
░░░▀▀░▀▀░░░';c=${RANDOM:2:1};l=12
;;
# Space Invaders
esac

printf '\e[3'"$c"'m%s\e[m\n\e[5A' "$a"


p='\e[33m\u\e[m@\h \e[3'"$c"'m\w\e[m'
# b=$(bats)
# for i in /sys/class/power_supply/{{BAT,axp288_fuel_gauge,CMB}*,battery}; do [[ -r $i/capacity ]] || continue; b+="${b:+, }$(< "$i/capacity")% $(< "$i/status")"; done

b="${b:+, }$(< "/sys/class/power_supply/battery/capacity")% $(< "/sys/class/power_supply/battery/status")"
printf "\\e[${l:-10}C%s\\n" \
	"${p@P}" \
	"OS:      $os" \
	"KERNEL:  $(uname -r)" \
	"${b:+BATTERY: }${b:-SHELL:   $(basename -- ${SHELL:-$0})}" \
	"$ui" \

# )

