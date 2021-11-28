#!/hint/sh

pacascii() {
lolcat <<PACASCII >&2 # ASCII source: http://www.ascii-art.de/ascii/pqr/pacman.txt + my 1 line added edit
================================================.
     .-.   .-.     .--.                         |
    | OO| | OO|   / _.-' .-.   .-.  .-.   .''.  |
    |   | |   |   \  '-. '-'   '-'  '-'   '..'  |
    '^^^' '^^^'    '--'                         |
===============.  .-.  .================.       |
               | |   | |                |  .-.  |
               | |   | |                |  '-'  |
               | '^^^' |                |       |
               |  .-.  |                |  .-.  |
               |  '-'  |                |  '-'  |
==============='       '================'       |
PACASCII
#'fix
}

alias \
	pacmna='(pacascii;pacman)' \
	pamcna='(pacascii;pacman)' \
	pacamn='(pacascii;pacman)' \
	pacmana='(pacascii;pacman)' \
	paccman='(pacascii;pacman)' \
\
\
	trien='(pacascii;trizen)' \
	rizen='(pacascii;trizen)' \
	trizzen='(pacascii;trizen)' \
	trizeen='(pacascii;trizen)' \
	trizn='(pacascii;trizen)' \
	trize='(pacascii;trizen)' \
	trizne='(pacascii;trizen)'\
	trzen='(pacascii;trizen)' \


alias p='trizen'  P='( YN_confirm "cleanup before upgrade" yes && sudo pacman -Rus $(pacman -Qtdq);   sudo sh -c "pacman -Sy && pacman -Fy && pacman -Su" && trizen -Sau )'
# p() {
#	return {
#		
#	}
#	
#	
#}



# trien
# trize
