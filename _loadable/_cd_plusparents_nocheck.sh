
_cd_plusparents_nocheck() { # alias cd++!
	[ -d "$1" ] || mkdir -p -- "$1"
	cd -- "$1"
}
