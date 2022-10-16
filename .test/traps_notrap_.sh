
die() { printf %s\\n " x> $1" >&2; }

####trap 'case $? in 0) ;; *) die failed{$?}!; esac' EXIT
####trap 'die killed!' KILL
# for i in `seq 64 | grep -vxF -e2 -e15 -e17`; do
#for i in `seq 64 | grep -vxF -e17`; do # 17 seems to run on every command exit (even on 0)
#for i in `seq 64`; do # 17 seems to run on every command exit (even on 0)
#	trap "die killed+{$i}!" $i
#done


pid=$$
{  set -x; sleep 1; kill -$@ $pid; } &


echo sleeping
sleep 3 || echo OR _C_
echo DONE _C_

