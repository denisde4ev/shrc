#!/bin/bash


IFS='\'

a="'\\'"

#{
#
#	shopt -s checkwinsize
#	n=$(( ${LINES:-0} * ${COLUMNS:-0} -1 )) || false  && \
#	[[ "${n:-0}" -gt 10 ]] || false
# 
#	# [[ "$n" -gt 10 ]] || exit "$n"
#	
#} || 
n=9833

i=3
while [[ "$n" -gt "$i" ]]; do
	a=${a@Q}
	i=${#a}
done

lolcat <<< $a

# return
# while [[ "$a" != "'\\'" ]]; do
	# eval "a=$a"
# done


# snowgen $LINES $COLUMNS | lolcat
