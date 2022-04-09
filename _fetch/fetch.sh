#!/bin/sh
set -eu

${os+:} . "${PREFIX-}"/etc/os-release # you can use: `( os=artix3 . ./<this_script>.sh )`
os=${os-${PRETTY_NAME:-${NAME:-$MACHTYPE}}}

_r=$(printf \\33[m) # reset color (and font_style)
c=4;l=11
case $os in
[Aa]rch*)a='
     .    
    / \   
   / _ \  
  / / \ \ 
 /`     `\
';;
[Aa]rco*)a='
     .    
    / \   
   / . \  
  / / _ \ 
 /`     `\
';;
[Aa]rtix*)a="
     .     
    / \\   
   /.  \\  
  /   * \\ 
 /   '   \\
";c=6;;
[Aa]rtix2)a="
     .     
    / \\   
   /'. \\  
  /   .'\\ 
 /   '   \\
";c=6;;
[Aa]rtix3*)a='

    /\   
   /  \  
  / 🎨 \ 
 /      \
';c=6;l=9;;
[Aa]lpine*) # use 2 colors for Alpine
_b=$(printf \\33[3'4'm) # blue
_w=$(printf \\33[3'7'm) # white
a="

   $_b/$_r$_b\\$_r
  $_b/$_r  $_b\\$_r $_r/\\$_r
 $_b/$_w◁$_r   $_b\\$_r  $_w\\$_r
";c=;l=12;;
[Aa]ndroid*)a='

 ╲_____╱ 
 ╱ . . ╲ 
▕       ▏
 ▔▔▔▔▔▔▔ 
';c=2;l=9;;
[Kk]iss*|KISS*)a='

 +----+ 
 | |/ | 
 | |\ | 
 +----+ 
';c=1;l=8;;
[Mm]anjaro*)a='

 █████ ██ 
 ██ ▄▄ ██ 
 ██ ██ ██ 
 ██ ██ ██ 
';c=2;l=10;;
# Space Invaders
*)a='
 ░░░▀▄░░░▄▀░░░ 
 ░░▄█▀███▀█▄░░ 
 ░█▀███████▀█░ 
 ░█░█▀▀▀▀▀█░█░ 
 ░░░░▀▀░▀▀░░░░ 
';
c=${RANDOM:2:1};l=15; os=${os:-👾};;
esac
: "${NEW_LINE:=
}"
a=${a#"$NEW_LINE"}
a=${a%"$NEW_LINE"}


printf "$_r${c:+"\\33[3${c}m"}%s" "$a" # prints ASCII



ui=$(tty) || : # gots false when "no a tty"
case $ui in /dev/tty*) false;; esac && \
if [ "${DE-}:${WM-}" != : ]; then    ui="${DE+DE}${DE+${WM+/}}${WM+WM}      ${DE+${WM+$'\33[3D'}}$DE${DE+${WM+/}}$WM"
elif [ "${XDG_CURRENT_DESKTOP-}:${DESKTOP_SESSION-}" != : ];   then ui="DE:      ${XDG_CURRENT_DESKTOP-}${XDG_CURRENT_DESKTOP+${DESKTOP_SESSION+, }}${DESKTOP_SESSION-}"
elif [ -r ~/.xinitrc ]||[ -r ~/.xsession ]; then
	x=''
	for i in $(sed -ne 's/^exec //p' ~/.xinitrc ~/.xsession "${XDG_CONFIG_HOME-$HOME/.config}"/xorg-xinit/xinitrc 2>/dev/null); do
		i=${i##*/}
		pidof -- "$i" >/dev/null 2>&1 && x=$x$i' '
	done
	[ "${x%" "}" != '' ] && ui="WM:      ${x%" "}"
else
	false # leave ui as `tty` output
fi || \
ui="TTY:     ${ui#/dev/}${SSH_TTY+, ssh}"


b='' # detect battery
for i in /sys/class/power_supply/{{BAT,axp288_fuel_gauge,CMB}*,battery}; do
	[ -r "$i/capacity" ] || continue
	read capacity < "$i"/capacity
	read status < "$i"/status
	b="$b${b:+, }$capacity% $status"
done


printf '\33[m\n\33[5A' # resets color and moves cursor to 5 lines up


u=\\33[3$((${EUID-$(id -u)}?3:1))m${USER-$(id -un)}\\33[m
# g=${GROUPS-$(id -ug)}
h=${HOSTNAME-$(hostname)}\\33[3
w=\\33[3${c}m${PWD##*/}\\33[m
printf "\\33[${l}C$u@$h $w\\n"


: "${SHELL=$0}"
printf "\\33[${l}C%s\\n" \
	"OS:      $os" \
	"KERNEL:  $(uname -r)" \
	"${b:+BATTERY:    }${b:-"SHELL:   ${SHELL##*/}"}" \
	"$ui" \
;
