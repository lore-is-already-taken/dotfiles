# Multimonitor support

import os
import random
import subprocess

from libqtile import bar
from libqtile.config import Screen
from libqtile.log_utils import logger

from .widgets import primary_widgets, secondary_widgets


def status_bar(widgets):
    return bar.Bar(widgets, 24, opacity=1)


def get_random_image(path: str = "/home/ivn/Pictures/wallpaper/") -> str:
    files = os.listdir(path)
    rand_index = random.randint(0, len(files) - 1)
    selected_image = path + files[rand_index]
    return selected_image


rand_wallpaper = get_random_image()

screens = [
    # Screen(top=status_bar(primary_widgets)),
    Screen(
        top=status_bar(primary_widgets),
        # You can uncomment this variable if you see that on X11 floating resize/moving is laggy
        # By default we handle these events delayed to already improve performance, however your system might still be struggling
        # This variable is set to None (no cap) by default, but you can set it to 60 to indicate that you limit it to 60 events per second
        # x11_drag_polling_rate=60,
        wallpaper=rand_wallpaper,
        wallpaper_mode="fill",
    ),
]

xrandr = "xrandr | grep -w 'connected' | cut -d ' ' -f 2 | wc -l"

command = subprocess.run(
    xrandr,
    shell=True,
    stdout=subprocess.PIPE,
    stderr=subprocess.PIPE,
)

if command.returncode != 0:
    error = command.stderr.decode("UTF-8")
    logger.error(f"Failed counting monitors using {xrandr}:\n{error}")
    connected_monitors = 1
else:
    connected_monitors = int(command.stdout.decode("UTF-8"))

if connected_monitors > 1:
    for _ in range(1, connected_monitors):
        screens.append(
            Screen(
                top=status_bar(secondary_widgets),
                wallpaper=rand_wallpaper,
                wallpaper_mode="fill",
            ),
        )
