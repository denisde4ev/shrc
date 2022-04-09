
_rm__() {

	case $1 in
		ssh[/-]known_host)
			# if [ -f ~/.ssh/known_hosts.d/"$1":1 ]; then
				rm ~/.ssh/known_hosts.d/"$2"
			# else
				# rm ~/.ssh/known_hosts.d/$1:1
			# fi
		;;
		pacman.lock) sudo rm /var/lib/pacman/db.lck;;
	esac
}
