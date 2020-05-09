#!/bin/bash
pid=$(ps -e | grep arma3server | cut -d" " -f2)
kill $pid