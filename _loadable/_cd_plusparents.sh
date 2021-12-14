
_cd_plusparents() { # alias cd++
	! [ -d "$1" ] || return 1
	mkdir -p -- "$1" && cd -- "$1"
}
