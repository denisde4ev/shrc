
#!/bin/sh

# allow git aliasses to be exapnded
# by bash's (bind alias-expand-line)

git_alias_aliases() {
	unset-unseted-i
	while read -r i; do
		#i=${i#alias.}
		case ${i#*" "} in
			\!*) alias "git_${i%%" "*}=${i#*" "\!}";;
			*)   alias "git_${i%%" "*}=git ${i#*" "}";;
		esac
	done <<- EOF
	$(git config --global --includes   --get-regexp '^alias\.')
	EOF
	unset-seted-i
	puts "aliases are :" >&2
	alias | sed 's/^alias //' | rg --pcre2 "(?<=git_alias\.)[^=]+(?==)" || {
		case $? in 1) echo 'no aliases' >&2; return 1;; esac
	}
}
