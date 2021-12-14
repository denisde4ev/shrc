
# song=_song
##TMP?
_song() { [ -t 0 -a -t 1 ] || return 1; ( set -f ; IFS='~';
	for i in $( \song | sed --null-data 's/\n\n/\x0/g' | shuf -z | tr \\0 \~ ); do
		echo "$i" | \
		sed -E 's/(\w)\s*$/\1 /g' | \
		\tt -showwpm -noskip -oneshot -raw -oneshot || break
	done
) }

# this could be moved to separate command???!
