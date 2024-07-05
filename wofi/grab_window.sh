#!/usr/bin/env bash

if [[ ! $(pidof wofi) ]]; then
    TITLE="$( hyprctl clients -j | jq 'unique_by(.title)' | jq .[] | jq -r .title | wofi --config ~/.config/wofi/config --style  ~/.config/wofi/styles.css --show dmenu )"
    if [ -n "$TITLE" ]; then
        hyprctl dispatch movetoworkspace $( hyprctl activeworkspace -j | jq .id ),title:"$TITLE"
    fi    
else
    pkill wofi
fi

