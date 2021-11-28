#!/bin/bash
return
(( SHLVL == 1 )) || return 2>/dev/null
[[ $blue ]] || . ~/B/__define_colors

# 1% chanse to recount
[[ $RANDOM = *00 ]] && pacman -Q | wc -l > /var/cache/pacman/count



(
# ufetch-arco - tiny system info for arco linux

## UI DETECTION
# set -x
if   [[ $(tty) = /dev/tty* ]];                         then uitype=TTY; ui=$'\e[1D'$(tty | sed 's@/dev/tty@@')
elif [[ $DE ]];                                        then uitype=DE; ui=$DE
elif [[ $WM ]];                                        then uitype=WM; ui=$WM
elif [[ $XDG_CURRENT_DESKTOP || $DESKTOP_SESSION ]];   then uitype=DE; ui=${XDG_CURRENT_DESKTOP:-}${XDG_CURRENT_DESKTOP:+ }${DESKTOP_SESSION:-}
elif [[ -f ~/.xinitrc ]];                              then uitype=WM; ui=$(sed -ne 's/^exec //p' ~/.xinitrc)
elif [[ -f ~/.xsession ]];                             then uitype=WM; ui=$(tail -n 1 ~/.xsession | cut -d ' ' -f 2)
else                                                        uitype=UI; ui=unknown
fi



lc=$reset$bold$blue         # labels
nc=$reset$bold$blue         # user and hostname
ic=$reset                   # info
c0=$reset$blue              # first color
# c0=$'\e[20C'$c0 

ps='${nc}\u$ic@${nc}\h$reset' # output like prompt string
# ps='${reset}'${PS1%% *}'$reset]'
shell=${0##*/}
[[ $shell = *ufetch* ]] && shell=${SHELL##*/}


cat << EOF

$c0        /\\        ${ps@P}
$c0       /  \\      $lc OS:       $ic ArcoLinux$reset
$c0      / /\\ \\     $lc KERNEL:    $ic$(uname -sr)$reset
$c0     / /  \\ \\    $lc UPTIME:    $ic$(uptime -p | sed 's/up //')$reset
$c0    / /    \\ \\   $lc PACKAGES:  $ic$(< /var/cache/pacman/count)$reset
$c0   / / -----\\ \\  $lc SHELL:     $ic$shell$reset
$c0  /_/  \`\`\`\`-.\\_\\  $lc$uitype:        $ic${ui##*/}$reset

EOF

)
