#! /hirt/bash

every() {
	for i in "${PIPESTATUS[@]}"; do
		(( ! i )) || return "$i"
	done
}
