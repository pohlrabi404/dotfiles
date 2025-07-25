# pylint: disable=C0111
from qutebrowser.config.configfiles import ConfigAPI  # noqa: F401
from qutebrowser.config.config import ConfigContainer  # noqa: F401
config: ConfigAPI = config  # noqa: F821 pylint: disable=E0602,C0103
c: ConfigContainer = c  # noqa: F821 pylint: disable=E0602,C0103

## Imports
config.source('theme.py')
config.load_autoconfig(True)

## Control
config.bind("<Ctrl-j>", "completion-item-focus next", mode="command")
config.bind("<Ctrl-k>", "completion-item-focus prev", mode="command")
config.bind("<Ctrl-f>", "completion-item-focus next-page", mode="command")
config.bind("<Ctrl-b>", "completion-item-focus prev-page", mode="command")

config.bind(";f", "hint links userscript mpv.sh")
