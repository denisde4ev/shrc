#! /hint/sh

P() {
	# also it keeps xtrace ( sh -x )
	sudo sh -u -c '
		YN_confirm y "cleanup before upgrade"; cleanup=$?
		YN_confirm n "update file database"; db_up=$?

		PS4="$ "
		set -x

		[ "$cleanup" = 0 ] && pacman -Rus $(pacman -Qtdq "$@") "$@"
		
		pacman -Sy "$@" || exit
		if [ "$db_up" ]; then
			 pacman -Fy "$@" || exit
		fi
		pacman "$@" -Su || exit
	' -s "$@" && \
	case $@ in
		*--noconfirm*) ;;
		*) trizen -Sau "$@" ;;
	esac
}

