#!/bin/sh

# systray battery icon
cbatticon -u 5 &
# systray volume
volumeicon &
picom &
xinput float $(xinput list | grep -i "generic mouse" | cut -d '=' -f2 | xargs | cut -d ' ' -f1)
#setxkbmap -layout latam
