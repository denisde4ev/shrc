#
# ~/.bashrc
#

#Ibus settings if you need them
#type ibus-setup in terminal to change settings and start the daemon
#delete the hashtags of the next lines and restart
#export GTK_IM_MODULE=ibus
#export XMODIFIERS=@im=dbus
#export QT_IM_MODULE=ibus

# If not running interactively, don't do anything
[[ $- == *i* ]] || return

export HISTCONTROL=ignoreboth:erasedups

PS1='[\u@\h \W]\$ '

[[ -d "$HOME/.bin" ]] && PATH="$HOME/.bin:$PATH"



#list
alias ls='ls --color=auto'
alias ll='ls -la'
alias l='ls'
alias l.="ls -A | egrep '^\.'"

#fix obvious typo's
#alias cd..='cd ..'
alias pdw="pwd"

## Colorize the grep command output for ease of use (good for log files)##
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

#readable output
alias df='df -h'

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
alias psgrep="ps aux | grep -v grep | grep -i -e VSZ -e"

#grub update
alias update-grub="sudo grub-mkconfig -o /boot/grub/grub.cfg"

#improve png
alias fixpng='find . -type f -name "*.png" -exec convert {} -strip {} \;'

#add new fonts
alias fc='sudo fc-cache -fv'

#copy/paste all content of /etc/skel over to home folder - Beware
alias skel='cp -rf /etc/skel/* ~'
#backup contents of /etc/skel to hidden backup folder in home/user
alias bupskel='cp -Rf /etc/skel ~/.skel-backup-$(date +%Y.%m.%d-%H.%M.%S)'

#copy bashrc-latest over on bashrc - cb= copy bashrc
alias cb="cp ~/.bashrc-latest ~/.bashrc && source ~/.bashrc && sudo cp /etc/skel/.bashrc-latest /etc/skel/.bashrc"

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
alias vbm='sudo mount -t vboxsf -o rw,uid=1000,gid=1000 Public "/home/$USER/Public"'

#shopt
shopt -s autocd # change to named directory
shopt -s cdspell # autocorrects cd misspellings
shopt -s cmdhist # save multi-line commands in history as single line
shopt -s dotglob
shopt -s histappend # do not overwrite history
shopt -s expand_aliases # expand aliases

shopt -s globstar # expen ** to all subfolders

#youtube-dl
alias yta-aac="youtube-dl --extract-audio --audio-format aac "
alias yta-best="youtube-dl --extract-audio --audio-format best "
alias yta-flac="youtube-dl --extract-audio --audio-format flac "
alias yta-m4a="youtube-dl --extract-audio --audio-format m4a "
alias yta-mp3="youtube-dl --extract-audio --audio-format mp3 "
alias yta-opus="youtube-dl --extract-audio --audio-format opus "
alias yta-vorbis="youtube-dl --extract-audio --audio-format vorbis "
alias yta-wav="youtube-dl --extract-audio --audio-format wav "

alias ytv-best="youtube-dl -f bestvideo+bestaudio "

#Recent Installed Packages
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -100"

#get the error messages from journalctl
alias jctl="journalctl -p 3 -xb"

#nano
alias nlightdm="sudo nano /etc/lightdm/lightdm.conf"
alias ngrub="sudo nano /etc/default/grub"
alias nmkinitcpio="sudo nano /etc/mkinitcpio.conf"
alias nslim="sudo nano /etc/slim.conf"
alias noblogout="sudo nano /etc/oblogout.conf"

#shutdown or reboot
alias ssn="sudo shutdown now"
alias sr="sudo reboot"

#create a file called .bashrc-personal and put all your personal aliases
#in there. They will not be overwritten by skel.


# [[ -f ~/.bashrc-personal ]] && . ~/.bashrc-personal


for i in ~/.bashrc-{personal,alias,\ pacman+yay}
do [[ -r $i ]] && source "$i"
done
unset i

# [[ "$PWD" =~ ^~"/0/gleec_/.gleec-base/" ]] && exec 'deepin-terminal -x su -c "kill -9 $$  & su gleec -c deepin-terminal"'
# [[ $PWD == ~ ]] && neofetch


# tricky way to get home dir without varable HOME
# real_HOME=`eval "echo ~${USER}"`
# f_home=$HOME:~
## WARING: probaly not safe - if is created ad useradd -


alias '{{'=do
alias '}}'=done
alias '{{{'=then
alias '}}}else{{{'=else # XD
alias '}}}elif'=elif # ...
alias '}}}'=fi
