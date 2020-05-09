#!/bin/bash

cp -p ~/backup/config/*.cfg ~/local/arma3/

if test -f "~/password.txt"
then
    ls ~/backup/config/*.cfg > ~/.config.txt
    local config="~/.config.txt"
    while IFS= read -r file
    do
        local passwords="~/password.txt"
        while IFS= read -r password
        do
            local old=$(echo $password | cut -d" " -f1)
            local new=$(echo $password | cut -d" " -f2)
            sed -i "s/${old}/${new}/g" $file
        done < "$passwords"
    done < "$config"
    rm ~/.config.txt
fi