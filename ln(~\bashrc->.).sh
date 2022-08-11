#! /bin/bash -x

echo 'TODO: compare to ./ln(.->~) and FIX ME'
exit 111

for i in ~/.bashrc*
do [[ -f $i ]] &&  ln -sr -- "$i" "./$(basename "$i")"
done
