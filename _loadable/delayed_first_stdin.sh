
delayed_first_stdin() { ( set -eu
	# todo! fix when: delayed_first_stdin $ grep .
	i=''
	IFS= read -r i
	{ printf %s\\n "$i"; cat; } | "${@:?}"
) }

# this could be moved to separate command?
