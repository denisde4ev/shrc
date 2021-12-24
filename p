#! /hint/sh

command. pacman || return

pacascii() {
lolcat <<PACASCII >&2  # ASCII source: http://www.ascii-art.de/ascii/pqr/pacman.txt + my small edit
=================================================.
     .-.   .-.     .--.                          |
    | OO| | OO|   / _.-' .-.   .-.  .-.    .''.  |
    |   | |   |   \  '-. '-'   '-'  '-'    '..'  |
    '^^^' '^^^'    '--'                          |
===============.  .-.  .=================.       |
               | |   | |                 |  .-.  |
               | |   | |                 |  '-'  |
               | '^^^' |                 |       |
               |  .-.  |                 |  .-.  |
               |  '-'  |                 |  '-'  |
==============='       '================='       |
PACASCII
#'fix
}

# AUR helper assuming trizen is installed
alias \
pacmna='$ "pacascii;pacman"' \
pamcna='$ "pacascii;pacman"' \
pacamn='$ "pacascii;pacman"' \
pacmana='$ "pacascii;pacman"' \
paccman='$ "pacascii;pacman"' \
\
\
trien='$ "pacascii;trizen"' \
rizen='$ "pacascii;trizen"' \
trizzen='$ "pacascii;trizen"' \
trizeen='$ "pacascii;trizen"' \
trizn='$ "pacascii;trizen"' \
trize='$ "pacascii;trizen"' \
trizne='$ "pacascii;trize")' \
trzen='$ "pacascii;trizen"' \
\
\
p='trizen'  P='__load_loadable_byfile %%PacmanSyu.sh P' \
rm.pacmanlock='rm /var/lib/pacman/db.lck' \
;
# p='trizen'  P='( sudo sh -c "\YN_confirm \"cleanup before upgrade\" yes && pacman -Rus $(pacman -Qtdq); pacman -Sy && { \YN_confirm "update file database" no || pacman -Fy; }  && pacman -Su" && trizen -Sau )' \

# p() {
#	return {
#		
#	}
#	
#	
#}



# trien
# trize
