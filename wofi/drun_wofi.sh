#!/usr/bin/env bash

if [[ ! $(pidof wofi) ]]; then
    wofi --show drun
else
    pkill wofi
fi

