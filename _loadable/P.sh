
P(){
	# also it keeps xtrace ( sh -x )
	sudo sh -u$( [ "$( (:) 2>&1 )" != '' ] && echo x ) -c '
		YN_confirm "cleanup before upgrade" yes; cleanup=$?
		YN_confirm "update file database" no; db_up=$?
		[ "$cleanup" = 0 ] && pacman -Rus $(pacman -Qtdq)
		
		pacman -Sy || exit
		if [ "$db_up" ]; then
			 pacman -Fy | exit
		fi
		pacman -Su || exit
	' && \
	trizen -Sau
}
