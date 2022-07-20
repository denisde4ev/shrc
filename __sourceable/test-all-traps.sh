

for i in `seq 64`; do # note: does not have EXIT trap
	trap "echo >&2 trap -- $i --" $i
done
unset i
