#!/usr/bin/env bash

if [[ ! $(pidof wofi) ]]; then
    wofi --show dmenu
else
    pkill wofi
fi

