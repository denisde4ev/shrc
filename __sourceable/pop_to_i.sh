#! /hint/sh
{ unset i; i=$#; while case $i in 0|1) false; esac; do set -- "$@" "$1"; shift; i=$(( i - 1 )); done; i=$1; shift; }
