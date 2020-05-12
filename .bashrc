#
# ~/.bashrc
#


# If not running interactively, don't do anything
[[ $- != *i* ]] && return `https://android.googlesource.com/toolchain/llvm`
# alias sudo=tsudo
#  PS1='${| local e=$? (( e )) && REPLY+="$e|" return $e }$HOSTNAME:${PWD:-?} $ '

#from arco linux
PS1='[\u@\h \W]﹩'
[[ -d "$HOME/.bin" ]] && PATH="$HOME/.bin:$PATH"


#

shopt -s expand_aliases
alias sshd-p22-d='sudo sshd -p 22 -d'
PATH+=:~/.bin-personal

if [[ ! $SSH_CONNECTION ]]
then
 startarch u u &&
 ufetch && echo -e '\e[2A\e[41C\e[48;5;8m\e[30m▀\e[m\e[48;5;9m\e[31m▀\e[m\e[48;5;10m\e[32m▀\e[m\e[48;5;11m\e[33m▀\e[m\e[48;5;12m\e[34m▀\e[m\e[48;5;13m\e[35m▀\e[m\e[48;5;14m\e[36m▀\e[m\e[48;5;15m\e[37m▀\e[m'\
 &&
 sshd-p22-d
#else
# su u0_a194 -c "PATH=$PATH;HOME=$HOME;bash -l"
# exit
fi
[[ -f ~/.bashrc-arco-alias ]] && . ~/.bashrc-arco-alias
[[ -f ~/.bashrc-personal ]] && . ~/.bashrc-personal
[[ -f ~/.bashrc-\ pacman+yay ]] && . ~/.bashrc-\ pacman+yay
alias sudo='read -p "[sudo] ^C to stop? " && sudo' # prompt before starting sudo
alias tsudo='/data/data/com.termux/files/usr/bin/sudo' # and old Termux's tsudo without confirm
