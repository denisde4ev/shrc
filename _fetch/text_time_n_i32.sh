#!/bin/sh


int_to_words() {
	case $(($1 / 10)) in
		0|1) case $1 in
			0) w="zero" ;; 1) w="one" ;; 2) w="two" ;; 3) w="three" ;; 4) w="four" ;;
			5) w="five" ;; 6) w="six" ;; 7) w="seven" ;; 8) w="eight" ;; 9) w="nine" ;;
			10) w="ten" ;; 11) w="eleven" ;; 12) w="twelve" ;; 13) w="thirteen" ;;
			14) w="fourteen" ;; 15) w="fifteen" ;; 16) w="sixteen" ;; 17) w="seventeen" ;;
			18) w="eighteen" ;; 19) w="nineteen" ;;
		esac ;;
		2) w="twenty" ;; 3) w="thirty" ;; 4) w="forty" ;; 5) w="fifty" ;;
		6) w="sixty" ;; 7) w="seventy" ;; 8) w="eighty" ;; 9) w="ninety" ;;
	esac

	[ "$1" -ge 20 ] && case $(($1 % 10)) in
		1) w="$w-one" ;; 2) w="$w-two" ;; 3) w="$w-three" ;; 4) w="$w-four" ;;
		5) w="$w-five" ;; 6) w="$w-six" ;; 7) w="$w-seven" ;; 8) w="$w-eight" ;; 9) w="$w-nine" ;;
	esac

	echo "$w"
}

# for now use sed command, I could change this someday


read h m p unix_seconds w mm << EOF
$(env -i date +'%-I %-M %p %s %-w %-m')
EOF


echo "It's" # todo: make it into accent color


# consider adding the prosentage of the season being passed, and estimated dais of the season, eg.: "middle of Summer (10days / 70, 60 left)"
case $mm in
	1)  echo "middle of Winter";;  # Jan
	2)  echo "end of Winter";;     # Feb
	3)  echo "start of Spring";;   # Mar
	4)  echo "middle of Spring";;  # Apr
	5)  echo "end of Spring";;     # May
	6)  echo "start of Summer";;   # Jun
	7)  echo "middle of Summer";;  # Jul
	8)  echo "end of Summer";;     # Aug
	9)  echo "start of Autumn";;   # Sep
	10) echo "middle of Autumn";;  # Oct
	11) echo "end of Autumn";;     # Nov
	12) echo "start of Winter";;   # Dec
esac | sed 's/^[a-z]/\U&/'

# 1582 Gregorian calendar oct 4th to 15th
# (not related to )

case $w in
	0) printf %s\\n "day before working day";;
	1) printf %s\\n "first working day";;
	2) printf %s\\n "second working day";;
	3) printf %s\\n "third working day";;
	4) printf %s\\n "forth working day";;
	5) printf %s\\n "fifth working day";;
	6) printf %s\\n "day after working day";;

	## if future sosiaty decides on 3 weekend days:
	#5) printf %s\\n "The day in at the start of the weekend";;
	#6) printf %s\\n "The day in at the middle of the weekend";;
	#7) printf %s\\n "The day in at the end of the weekend";;
	

	#6) printf %s\\n "The first non working day";;
	#7) printf %s\\n "The second non working day";;

esac | sed 's/^[a-z]/\U&/'



case $p:$h in
	AM:12)               printf %s\\n "Midnight";;
	AM:[1-5])            printf %s\\n "Late night";;
	AM:[6-9]|AM:1[0-1])  printf %s\\n "Morning";;
	PM:12)               printf %s\\n "Noon";;
	PM:[1-5])            printf %s\\n "Afternoon";;
	PM:[6-9])            printf %s\\n "Evening";;
	PM:1[0-1])           printf %s\\n "Night";;
	*)                   printf %s\\n "Unknown";;
esac



{
	# todo: uuum, what about "PM"/"AM", how do I add it in this spagetti code

	int_to_words "$h" # ez trim start zero


# TODO: overcomplicate this even more, eg.: "half past 10"

	case $m in
		0|00) echo "O'Clock";;
		1|01) echo "O'One";;
		2|02) echo "O'Two";;
		3|03) echo "O'Three";;
		4|04) echo "O'Four";;
		5|05) echo "O'Five";;
		6|06) echo "O'Six";;
		7|07) echo "O'Seven";;
		8|08) echo "O'Eight";;
		9|09) echo "O'Nine";;

# TODO: check 20:10
		1-9|01-09) printf ;;
		*) int_to_words "$m";;
	esac
#} | sed 'y/-/\n/; s/^[a-z]/\U&/'
} | tr '-' '\n' | sed 's/^[a-z]/\U&/'


echo # one empty line before binary clock

i=31
while case $i in -1) false; esac; do
	case "$(( ( unix_seconds >> i ) & 1 ))" in
		1) printf '\342\227\217';; # (when utf8), bash: printf '\u25CF';;
		0) printf '\342\227\213';; # (when utf8), bash: printf '\u25CB';;
	esac
	case $i in
		6) printf ':';; # seconds = 60 -> rufly 6 bits 64
		12) printf ':';; # minutes =  60 -> rufly 6 bits 64
		17) printf 'T';;  # hours = 24 -> rufly 5 bits 32
		22) printf '-';;  # days = 28-31 -> rufly 5 bits 32
		25) printf '-';;  # monts = 12 ->  rufly 4 bits 16 (BUT idk first year takes les then 16 bits) -> 3 bits
	esac
	i=$(( i - 1 ))
done
echo

unset h m p i unix_seconds
