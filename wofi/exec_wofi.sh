#!/usr/bin/env bash

if [[ ! $(pidof wofi) ]]; then
    wofi --conf ~/.config/wofi/config --style ~/.config/wofi/style.css  --show drun
else
    pkill wofi
fi

