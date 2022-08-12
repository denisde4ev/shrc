#
# ~/.bashrc
#

#Ibus settings if you need them
#type ibus-setup in terminal to change settings and start the daemon
#delete the hashtags of the next lines and restart
#export GTK_IM_MODULE=ibus
#export XMODIFIERS=@im=dbus
#export QT_IM_MODULE=ibus


case $HOSTNAME in localhost) . ~/.termux/boot/apply-on-boot-personal; esac

# If not running interactively, don't do anything
[[ $- == *i* ]] && \
bind '"\b": unix-word-rubout' # OldBackspace/Ctrl-Backspace -> kill prev. word

#TODO: alias '_0' to be in  /^/_/git-branch=master**

alias \
_0='cd  /\^/\ https://github.com/denisde4ev/_0/raw/master/' \
bb=busybox \
ip='bb ip' \
dust='dust -r' \
markor='cd /0/Documents/markor/' \
markor-qn='edit /0/Documents/markor/QuickNote.md' \
;


##{ termux-sms-send -n 1875 STOP& disown; }
export HISTCONTROL=ignoreboth:erasedups

PS1='[\u@\h \W]\$ '

# [[ -d "$HOME/.bin" ]] &&



alias tt='tt -showwpm -noskip -oneshot -raw'
#list
alias ls='ls --color=auto'
alias ll='ls -lA'
alias l='ls -al'
alias l.="ls -A | egrep '^\.'"

#fix obvious typo's
#alias cd..='cd ..'
alias pdw="pwd"

## Colorize the grep command output for ease of use (good for log files)##
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

#readable output
alias df='df -h' du='du -h'

#free
alias free="free -mt"

#use all cores
alias uac="sh ~/.bin/main/000*"

#continue download
alias wget="wget -c"

#userlist
alias userlist="cut -d: -f1 /etc/passwd"

#merge new settings
alias merge="xrdb -merge ~/.Xresources"

# yay as aur helper - updates everything
alias pksyua="yay -Syu --noconfirm"
alias upall="yay -Syu --noconfirm"

#ps
alias ps="ps auxf"
alias psgrep="ps aux | grep -v grep | grep --color=auto -i -e VSZ -e"

#grub update
alias update-grub="grub-mkconfig -o /boot/grub/grub.cfg"

#improve png
alias fixpng='find . -type f -name "*.png" -exec convert {} -strip {} \;'

#add new fonts
alias fc='fc-cache -fv'

#copy/paste all content of /etc/skel over to home folder - Beware
alias skel='cp -rf /etc/skel/* ~'
#backup contents of /etc/skel to hidden backup folder in home/user
alias bupskel='cp -Rf /etc/skel ~/.skel-backup-$(date +%Y.%m.%d-%H.%M.%S)'

#### #copy bashrc-latest over on bashrc - cb= copy bashrc
#### alias cb="cp ~/.bashrc-latest ~/.bashrc && source ~/.bashrc && cp /etc/skel/.bashrc-latest /etc/skel/.bashrc"

#quickly kill conkies
alias kc='killall conky'

#hardware info --short
alias hw="hwinfo --short"

#skip integrity check
alias yayskip='yay -S --mflags --skipinteg'
alias trizenskip='trizen -S --skipinteg'

#check vulnerabilities microcode
alias microcode='grep . /sys/devices/system/cpu/vulnerabilities/*'

#mounting the folder Public for exchange between host and guest on virtualbox
alias vbm=' mount -t vboxsf -o rw,uid=1000,gid=1000 Public "/home/$USER/Public"'

#shopt
shopt -s autocd # change to named directory
shopt -s cdspell # autocorrects cd misspellings
shopt -s cmdhist # save multi-line commands in history as single line
shopt -s dotglob
shopt -s histappend # do not overwrite history
shopt -s expand_aliases # expand aliases

#shopt -s globstar # expand ** to all subfolders # too many DoS acidents `killall -13 bash`

#youtube-dl is moved to ~/.bin

#Recent Installed Packages
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -100"

#get the error messages from journalctl
alias jctl="journalctl -p 3 -xb"

#nano -> edit
alias e.lightdm="edit /etc/lightdm/lightdm.conf"
alias e.grub="edit /etc/default/grub"
alias e.mkinitcpio="edit /etc/mkinitcpio.conf"
alias e.slim="edit /etc/slim.conf"
alias e.oblogout="edit /etc/oblogout.conf"

#shutdown or reboot
alias shutdown='\shutdown now'
alias reboot='\reboot'






alias command.='&>/dev/null command -v'
# for i in \~/.bashrc-{personal,alias,\ pacman+yay,Z,termux}
. ~/BB/.bashrc-personal
# . ~/BB/.bashrc-alias
. ~/BB/.'bashrc- pacman+yay'
. ~/BB/.bashrc-Z
. ~/BB/.bashrc-termux

# [[ "$PWD" =~ ^~"/0/gleec_/.gleec-base/" ]] && exec 'deepin-terminal -x su -c "kill -9 $$  & su gleec -c deepin-terminal"'
# [[ $PWD == ~ ]] && neofetch


# tricky way to get home dir without varable HOME
# real_HOME=`eval "echo ~${USER}"`
# f_home=$HOME:~
## WARING: probaly not safe - if is created ad useradd -


alias '{{'=do
alias '}}'=done
alias '{{{'=then
alias 'if{{{'=if
alias '}}}elif'=elif # ...
alias '}}}else{{{'=else # lol
alias '}}}'=fi


alias tb="nc termbin.com 9999"
alias grep='grep --color=auto'
alias bat='bat --pager less'
alias ping='ping -c 5'
alias diff='diff --color=auto'
alias 192="ip address show|grep '192\\.168\\.[0-9]{1,3}\\.[0-9]{1,3}'"
alias swaperr='3>&1 1>&2 2>&3'

alias 7zip9='7z a -r -t7z -m0=lzma2 -mx=9 -myx=9 -mqs=on -ms=on' 79=7zip9


alias gin-barehome='git --git-dir ~/cfg/.git --work-tree ~'
complete -o bashdefault -o default -o nospace -F __git_wrap__git_main config; __git_wrap__git_main(){ __load_completion git && __git_wrap__git_main "$@"; }

alias eXport-Xserver='export DISPLAY=:0 PULSESERVER=127.0.0.1:4713'
PATH=$PATH:~/bin/start-proots
# pfetch


#if has't arg &  is "set -x" used
case $- in *c*) ;; *) # not bash -lc '...'
	# have no arguments
	# and is not in xtrace -> set -x
	[ $# -eq 0 ] && \
	[ "$({ :; } 2>&1)" = '' ] && \
		( . ~/BB/_fetch/.2020-12-24%yfetch.bash ) \
	;
esac

. ~/BB/.bashrc-01






##{
##	my_grep_prop() {                                                                                                                                                                               
##	  # local REGEX="s/$1=//p"
##	  # shift
##	  # local FILES=$@
##	  # [ -z "$FILES" ] && FILES='/system/build.prop /vendor/build.prop /product/build.prop'
##	  # sed -n "$REGEX" $FILES 2>/dev/null | head -n 1
##	  getprop | sed -nEe "/$1\\]/{s/^\\[?(.+)$1\\](: \\[)?(.+)(\\]|$)/\\1\\3/p }"
##	} 
##}

alias BAT='bat -A'
alias remote="su -c \\''/^/ https:/github.com/denisde4ev/android-keycodes/raw/master/remote.sh'\\'"
