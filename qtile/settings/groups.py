# Qtile workspaces

from libqtile.command import lazy
from libqtile.config import Group, Key

from .keys import keys, mod

# Get the icons at https://www.nerdfonts.com/cheat-sheet (you need a Nerd Font)
# Icons:
# nf-fa-firefox,
# nf-fae-python,
# nf-dev-terminal,
# nf-fa-code,
# nf-oct-git_merge,
# nf-linux-docker,
# nf-mdi-image,
# rub-mkconfig -o /boot/grub/grub.cfg nf-mdi-layers
icon_groups = [
    "1  ",
    "2  ",
    "3  ",
    "4  ",
    "5  ",
    "6  ",
    "7 󰓇 ",
    "8 󰙯 ",
    "9  ",
]
groups = [Group(i) for i in icon_groups]

for i, group in enumerate(groups):
    actual_key = str(i + 1)
    keys.extend(
        [
            # Switch to workspace N
            Key([mod], actual_key, lazy.group[group.name].toscreen()),
            # Send window to workspace N
            Key([mod, "shift"], actual_key, lazy.window.togroup(group.name)),
        ]
    )
