#! /bin/bash -x
b(){ echo -n "\e[1m$@\e[m"; }
[[ $@ == --help ]] && {
echo -en "make symbolic link from `b repo` to `b ~`

Usage: `basename -- "$0"` [DIR_REPO] [~|HOME_DIR]
       default for DIR_REPO: .
       default for HOME_DIR: ~
"
exit 0
}

DIR_REPO=${1:-.}
HOME_DIR=${2:-~}

set -x

c(){
echo -n "$@
Continue anyway? [Y/n]:"
[[ `head -1` =~ ^[Yy]es$|^$ ]] || exit 
}
[[ -d $DIR_REPO/.git ]] || c "Are you shure you want to copy `b from` ${DIR_REPO@Q} , .git was not found"
[[ -d $HOME_DIR ]] || c "Are you shure you want to copy `b to` ${HOME_DIR@Q}"
[[ git config --get remote.origin.url =~ 'github.com:deni2020/.bashrc.d.git'$ ]] || c 'My git url was not found in git config?!'




exit 111
for i in $DIR_REPO/*
# -f  FILE exists and is a regular file
do [[ -f $i ]] &&  ln -- "$i" "./$(basename -- "$i")"
done