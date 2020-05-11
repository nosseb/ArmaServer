#!/bin/bash
# Provided under MIT Licence
# https://github.com/nosseb/Ehwaz
version=2.0

if [ -z "$1" ]
    then
        printf "Insuficient argument supplied" >&2
        exit 128
fi

#TODO: improve behaviour on failure
cd ~/arma3 || exit
nohup ./arma3server -config="$1" &