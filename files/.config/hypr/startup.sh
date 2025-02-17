#!/usr/bin/env zsh
monitor_count=$(hyprctl monitors | grep -c "Monitor")
if [ $monitor_count -ge 2 ]; then
    hyprctl dispatch workspace 2
fi
hyprctl dispatch exec qutebrowser
