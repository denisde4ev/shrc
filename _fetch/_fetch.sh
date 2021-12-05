#!/bin/sh

( cd ~/B/_fetch && . "$(printf '%s\n' ./[!_.%]*[!%~] | shuf -n 1)" ) 
