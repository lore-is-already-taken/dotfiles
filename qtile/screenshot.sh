#!/bin/bash
echo -n | xclip -selection clipboard && scrot -f -q 100 -s -e 'xclip -selection clipboard -t image/png -i $f && mv $f /tmp/screenshot.png'
