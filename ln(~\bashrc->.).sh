#! /bin/bash -x

for i in ~/.bashrc*
do [[ -f $i ]] &&  ln -- "$i" "./$(basename "$i")"
done