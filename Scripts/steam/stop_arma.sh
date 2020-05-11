#!/bin/bash
# Provided under MIT Licence
# https://github.com/nosseb/Ehwaz
version=2.0

pid=$(pgrep arma3server | cut -d" " -f2)
kill "$pid"