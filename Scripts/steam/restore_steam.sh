#!/bin/bash
# Provided under MIT Licence
# https://github.com/nosseb/Ehwaz
version=2.0

rsync -ar --delete ~/backup/.steam ~/local
rsync -ar --delete ~/backup/Steam ~/local
rsync -ar --delete ~/backup/arma3 ~/local