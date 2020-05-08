#!/bin/bash

# Make a list of config files to ignore
ls ~/config/ > ~/.config.txt

# Sync steam
if [ -s ~/.config.txt ]
    then
        rsync -ar --delete ~/local/.steam ~/backup
    else
        rsync -ar --delete --exclude-from=~/.config.txt ~/local/.steam ~/backup
fi
rsync -ar --delete ~/local/Steam ~/backup
rsync -ar --delete ~/local/arma3 ~/backup

# Remove the list of ignored files
rm ~/.config.txt