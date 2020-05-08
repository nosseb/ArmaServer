#!/bin/bash
rsync -ar --delete ~/backup/.steam ~/local
rsync -ar --delete ~/backup/Steam ~/local
rsync -ar --delete ~/backup/arma3 ~/local