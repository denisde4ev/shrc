#! /bin/bash -x

for i in ${1:-~}/.bashrc*
do [[ -f $i ]] &&  ln -- "$i" "./$(basename "$i")"
done
