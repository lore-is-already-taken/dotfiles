# Qtile keybindings

import datetime
import platform

from libqtile.config import Key
from libqtile.lazy import lazy

timestamp = datetime.datetime.now().strftime("%Y%m%d_%H%M%S")
filename = f"/tmp/screenshot_{timestamp}.png"


mod = "mod4"
hostname = platform.node()
sound_card = {
    "hopstrocity": 1,
    "smitten": 0,
}.get(hostname, 0)

keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key(
        [mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"
    ),
    Key(
        [mod, "shift"],
        "l",
        lazy.layout.shuffle_right(),
        desc="Move window to the right",
    ),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key(
        [mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"
    ),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key([mod], "Return", lazy.spawn("kitty"), desc="Launch terminal"),
    Key(
        [mod, "shift"], "Return", lazy.spawn("alacritty"), desc="Launch kitty terminal"
    ),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),
    Key(
        [mod],
        "f",
        lazy.window.toggle_fullscreen(),
        desc="Toggle fullscreen on the focused window",
    ),
    Key(
        [mod],
        "t",
        lazy.window.toggle_floating(),
        desc="Toggle floating on the focused window",
    ),
    Key([mod], "p", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    # Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
    # custom
    Key([mod, "shift"], "B", lazy.spawn("brave"), desc="open Brave Browser"),
    Key([mod, "shift"], "D", lazy.spawn("discord"), desc="Open Discord "),
    Key(
        [mod],
        "d",
        lazy.spawn(
            "rofi -show run"
        ),
        desc="open Rofi",
    ),
    Key(
        [mod, "control"],
        "o",
        lazy.spawn("/home/ivn/repos/Obsidian-1.5.8.AppImage &"),
        desc="Run Obsidian ",
    ),
    Key(
        [mod, "shift"],
        "p",
        lazy.spawn("thunderbird --force-device-scale-factor=1.5 &"),
        desc="open thunderbird",
    ),
    # bright
    Key(
        [],
        "XF86MonBrightnessUp",
        lazy.spawn("brightnessctl -d intel_backlight set 1%+"),
    ),
    Key(
        [],
        "XF86MonBrightnessDown",
        lazy.spawn("brightnessctl -d intel_backlight set 1%-"),
    ),
    # Key([], "XF86MonBrightnessUp", lazy.spawn("maclight screen up")),
    # Key([], "XF86MonBrightnessDown", lazy.spawn("maclight screen down")),
    # sound
    Key(
        [],
        "XF86AudioRaiseVolume",
        lazy.spawn("amixer -c %d -q set Master 2dB+" % sound_card),
    ),
    Key(
        [],
        "XF86AudioLowerVolume",
        lazy.spawn("amixer -c %d -q set Master 2dB-" % sound_card),
    ),
    # screen shot
    Key(
        [mod, "shift"],
        "s",
        lazy.spawn(
            "scrot -f -q 100 -s '/tmp/%Y-%m-%d_%H%M%S_screenshot.png' -e 'xclip -selection clipboard -t image/png -i $f'"
        ),
        desc="take a screen shot and copy to the clipboard",
    ),
]
