#!/bin/bash
# Provided under MIT Licence
# https://github.com/nosseb/Ehwaz
version=2.0

cp -p ~/backup/config/*.cfg ~/local/arma3/

if [ -f ~/password.txt ]
then
    config=~/config.txt
    ls ~/local/arma3/*.cfg > $config
    while IFS= read -r file
    do
        passwords=~/password.txt
        while IFS= read -r password
        do
            old=$(echo "$password" | cut -d" " -f1)
            new=$(echo "$password" | cut -d" " -f2)
            sed -i "s/${old}/${new}/g" "$file"
        done < $passwords
    done < $config
fi