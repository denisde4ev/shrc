#! /bin/bash -x
b(){ echo -e "\e[1m$*\e[m"; } # BOLD
[[ $* == --help ]] && {
  echo -n "make symbolic link from `b repo` to `b ~`

Usage: `basename -- "$0"` [DIR_REPO] [~|HOME_DIR]
       default for DIR_REPO: .
       default for HOME_DIR: ~
"
  exit 0
}

DIR_REPO=${1:-.}
HOME_DIR=${2:-~}

set -x

confirm(){
  echo -n "$*
  Continue anyway? [Y/n]:"
  [[ `head -1` = @([Yy]?(es)|YES|) ]] || exit 1
}
[[ -d $DIR_REPO/.git ]] || confirm "Are you shure you want to copy `b from` ${DIR_REPO@Q} , .git was not found"
[[ -d $HOME_DIR ]] || confirm "Are you shure you want to copy `b to` ${HOME_DIR@Q}"
[[ "`git config --get remote.origin.url`" = *'gitgud.io'[/:]'denisde4ev/cfg'?(.git) ]] || confirm 'My git url was not found in git config?!'


# echo "$DIR_REPO"/.bashrc!(@|_)*
exit 2
for i in "$DIR_REPO"/.bashrc!(@|_)
# -f  FILE exists and is a regular file
do [[ -f $i ]] &&  ln -vi -sr -- "$i" "$HOME_DIR/$(basename -- "$i")"
done
