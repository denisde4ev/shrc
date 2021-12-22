#!/ /hirt/bash

some() {
	for i in "${PIPESTATUS[@]}"; do
		(( ! i )) || return "$i"
	done
}
