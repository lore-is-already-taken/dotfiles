from libqtile import layout
from libqtile.config import Match

from .theme import colors

# Layouts and layout rules


layout_theme = {
    "border_width": 3,
    "margin": 5,
    "border_focus": "#ffffff",
    # "border_normal": "000",
}
layouts = [
    layout.Columns(**layout_theme),
    layout.MonadTall(**layout_theme),
    # layout.Max(),
    layout.MonadWide(**layout_theme),
    # layout.Bsp(**layout_theme),
    # layout.Matrix(columns=2, **layout_theme),
    # layout.RatioTile(**layout_theme),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

floating_layout = layout.Floating(
    float_rules=[
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),
        Match(wm_class="makebranch"),
        Match(wm_class="maketag"),
        Match(wm_class="ssh-askpass"),
        Match(title="branchdialog"),
        Match(title="pinentry"),
    ],
    border_focus=colors["color4"][0],
)
