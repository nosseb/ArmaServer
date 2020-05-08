#!/bin/bash

if [ -z "$1" ]
    then
        printf "Insuficient argument supplied" >&2
        exit 128
fi

cd ~/arma3
nohup ./arma3server -config=$1 &