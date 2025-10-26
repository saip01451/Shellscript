#!/bin/bash

NAME=""
WISHES="Good Morning"

USAGE(){
    echo "USAGE:: $(basename $0) -n <name> -w <wishes>"
    echo "options::"
    echo " -n, specify the name (mandatory)"
    echo " -w, specify the wishes. (optinal).Default is Good morning"
    echo " -h, Display Help and exit"
}

while getops ":n:w:h" opt; do
    case $opt in
        n) NAME="$OPTARG";;
        w) WISHES="$OPTARD";;
        \?) echo "invalid options: -"$OPTARG"" >&2; USAGE; exit;;
        :) USAGE; exit;;
        h) USAGE; exit;;
    esac
done

#if [ -2 "$name" ] || {-z "WISHES" ]; then
if [ -z "$NAME" ];then # now wishes is optional
    #echo "ERROR: Both -n and -w are mandatory option."
    echo "ERROR: -n is mandatory."
    USAGE
    exit 1
fi

echo "Hello $NAME. $WISHES. I have been learning shell script since long."