#!/bin/sh

# allow git aliasses to be exapnded
# by bash's (bind alias-expand-line)

git_alias_aliases() {
	unset-unseted-i
	while read -r i; do
		#i=${i#alias.}
		case ${i#*" "} in
			\!*) alias "git.${i%%" "*}=${i#*" "\!}";;
			*) alias "git.${i%%" "*}=git ${i#*" "}";;
		esac
	done <<-.
	$(git config --global   --get-regexp '^alias\.')
	.
	unset-seted-i
}
