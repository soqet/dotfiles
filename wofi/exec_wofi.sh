#!/usr/bin/env bash

CONFIG="~/.config/wofi/config"
STYLE="~/.config/wofi/styles.css"

if [[ ! $(pidof wofi) ]]; then
    wofi --conf ~/.config/wofi/config --style ~/.config/wofi/styles.css  --show drun
else
    pkill wofi
fi

