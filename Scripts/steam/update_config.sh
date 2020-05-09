#!/bin/bash

cp -p ~/backup/config/*.cfg ~/local/arma3/

if [ -f ~/password.txt ]
then
    ls ~/backup/config/*.cfg > ~/.config.txt
    config="~/.config.txt"
    while IFS= read -r file
    do
        passwords="~/password.txt"
        while IFS= read -r password
        do
            old=$(echo $password | cut -d" " -f1)
            new=$(echo $password | cut -d" " -f2)
            sed -i "s/${old}/${new}/g" $file
        done < "$passwords"
    done < "$config"
    rm .config.txt
fi