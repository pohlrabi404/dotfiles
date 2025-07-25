#!/usr/bin/env bash
# mpv-add-or-launch.sh  (updated)

set -euo pipefail

# ------------------------------------------------------------------ variables
SOCKET="${XDG_RUNTIME_DIR:-/tmp}/mpv-socket"

# ------------------------------------------------------------------ functions
start_mpv() {
    exec mpv --input-ipc-server="$SOCKET" "$QUTE_URL"
}

send_to_playlist() {
    printf '{ "command": ["loadfile", "%s", "append-play"] }\n' "$QUTE_URL" | socat - "$SOCKET"
}

# ------------------------------------------------------------------ main
if [[ -S $SOCKET ]]; then
    if send_to_playlist; then
        echo "Added to existing mpv playlist."
    else
        echo "Socket stale, starting new mpv."
        start_mpv
    fi
else
    start_mpv
fi
