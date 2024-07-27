from libqtile.lazy import lazy


def take_screenshot():
    timestamp = datetime.datetime.now().strftime("%Y%m%d_%H%M%S")
    filename = f"/tmp/screenshot_{timestamp}.png"

    command = [
        "scrot",
        "-f",
        "-q",
        "100",
        "-s",
        "-e",
        f"xclip -selection clipboard -t image/png -i $f && mv $f {filename} && echo {filename}",
    ]

    try:
        lazy.spawn(command)
    except subprocess.CalledProcessError as e:
        print(f"Error taking screenshot: {e}")
        return None
