#!/bin/bash

if [ -z "$1" ]
    then
        printf "Insuficient argument supplied" >&2
        exit 128
fi
if [ -z "$2" ]
    then
        printf "Insuficient argument supplied" >&2
        exit 128
fi

steamcmd +login $1 $2 +force_install_dir /home/steam/arma3 +app_update 233780 validate +quit