from libqtile import widget

from .theme import colors

# Get the icons at https://www.nerdfonts.com/cheat-sheet (you need a Nerd Font)


def base(fg="text", bg="dark"):
    return {"foreground": colors[fg], "background": colors[bg]}


def separator():
    return widget.Sep(**base(), linewidth=0, padding=5)


def icon(fg="text", bg="dark", fontsize=16, text="?"):
    return widget.TextBox(**base(fg, bg), fontsize=fontsize, text=text, padding=3)


def powerline(foreground: str = "light", background: str = "dark"):
    return widget.TextBox(
        **base(foreground, background),
        text=" ",
        fontsize=37,
        padding=1,  # Icon: nf-oct-triangle_left
    )


def workspaces():
    return [
        separator(),
        widget.GroupBox(
            **base(fg="light"),
            font="UbuntuMono Nerd Font",
            fontsize=19,
            margin_y=3,
            margin_x=2,
            # padding_y=9,
            padding_x=5,
            borderwidth=1,
            active=colors["active"],
            inactive=colors["inactive"],
            rounded=False,
            highlight_method="block",
            urgent_alert_method="block",
            urgent_border=colors["urgent"],
            this_current_screen_border=colors["focus"],
            this_screen_border=colors["grey"],
            other_current_screen_border=colors["dark"],
            other_screen_border=colors["dark"],
            disable_drag=True,
        ),
        separator(),
        widget.WindowName(**base(fg="focus"), fontsize=14, padding=5),
        separator(),
    ]


primary_widgets = [
    *workspaces(),
    separator(),
    ##
    powerline("color2", "dark"),
    ##
    icon(bg="color2", text="󰧑  "),
    widget.CPU(
        **base(bg="color2"),
        # background=colors["color2"],
        format="{load_percent} %",
        fontsize=17,
        update_interval=1,
    ),
    #
    ## for check updates
    powerline("color4", "color2"),
    ###
    icon(bg="color4", text=" "),  # Icon: nf-fa-download
    widget.CheckUpdates(
        background=colors["color4"],
        colour_have_updates=colors["text"],
        colour_no_updates=colors["text"],
        no_update_string="0",
        display_format="{updates}",
        update_interval=3,
        custom_command="checkupdates",
    ),
    ##
    powerline("color3", "color4"),
    ##
    ## for check updates
    #
    # wifi info
    icon(bg="color3", text=" "),  # Icon: nf-fa-feed
    widget.Net(
        **base(bg="color3"),
        interface="wlp1s0",
        format="{down:.1f}{down_suffix} ↓↑ {up:.1f}{up_suffix}",
        prefix="M",
        update_interval=1,
    ),
    # wifi info
    #
    # show currend layout
    powerline("color1", "color3"),
    ##
    # widget.CurrentLayoutIcon(**base(bg="color2"), scale=0.65),
    # widget.CurrentLayout(**base(bg="color2"), padding=5),
    # powerline("color1", "color2"),
    icon(bg="color1", fontsize=19, text=" "),  # Icon: nf-mdi-calendar_clock
    widget.Clock(**base(bg="color1"), format="%H:%M"),
    powerline("color4", "color1"),
    widget.Battery(
        **base(bg="color4"),
        charge_char="󰂄 ",
        discharge_char="󱟢 ",
        format="{char}{percent:2.1%}",
        update_interval=1,
    ),
    powerline("color3", "color4"),
    icon(bg="color3", fontsize=19, text="󰝚 "),  # Icon: nf-mdi-calendar_clock
    widget.Volume(**base(bg="color3")),
]

secondary_widgets = [
    *workspaces(),
    separator(),
    powerline("color1", "dark"),
    widget.CurrentLayoutIcon(**base(bg="color1"), scale=0.65),
    widget.CurrentLayout(**base(bg="color1"), padding=5),
    powerline("color2", "color1"),
    widget.Clock(**base(bg="color2"), format="%d/%m/%Y - %H:%M "),
    powerline("dark", "color2"),
]

widget_defaults = {
    "font": "UbuntuMono Nerd Font Bold",
    "fontsize": 14,
    "padding": 1,
}
extension_defaults = widget_defaults.copy()
