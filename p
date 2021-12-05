#!/hint/sh

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
p='trizen'  P='( sudo sh -c "\YN_confirm \"cleanup before upgrade\" yes && pacman -Rus $(pacman -Qtdq); pacman -Sy && pacman -Fy && pacman -Su" && trizen -Sau )' \
;

# p() {
#	return {
#		
#	}
#	
#	
#}



# trien
# trize
