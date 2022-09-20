#!/bin/sh

case ${XKB_DEFAULT_LAYOUT} in
#case us in

# ascii src: http://mkweb.bcgsc.ca/carpalx/?readme
'us(carpalx)') printf %s \
"                             ___   __
                            | \\ \\ / /
   ___ __ _ _ __ _ __   __ _| |\\ V /
  / __/ _\` | '__| '_ \\ / _\` | | > <
 | (_| (_| | |  | |_) | (_| | |/ . \\
  \\___\\__,_|_|  | .__/ \\__,_|_/_/ \\_\\
                | |
                |_| 
";;

# TODO:! NEVER TESTED, test what is us OR us(querty)
us|'us(qwerty)') printf %s \
'1 2 3 4 5 6 7 8 9 0 - =
Q W E R T Y U I O P [ ] \
A S D F G H J K L ; '\''
Z X C V B N M , . /
' #fix'
;;

# IDK what to do in case like this.
# printing your keyboard is not recognized
# or not supported by this script is not fun.
# let me.. uh, **um...** (its perfect, I guess)
*) printf um...\\n;;

esac | lolcat
