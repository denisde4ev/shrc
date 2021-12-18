
P(){
	# also it keeps xtrace ( sh -x )
	sudo sh -eu$( [ "$((:) 2>&1)" != '' ] && echo x ) -c "
		if YN_confirm \"cleanup before upgrade\" yes; then
			pacman -Rus $(pacman -Qtdq) || :
		fi
		pacman -Sy
		if YN_confirm \"update file database\" no; then
			pacman -Fy
		fi
		pacman -Su
	" && \
	trizen -Sau
}
