#!/bin/bash
mkdir -p ~/.local/bin
cat > ~/.local/bin/stow-home-sync.sh <<EOF
#!/bin/sh
# Absolute path to the directory that contains the stow package “home”
PKGDIR="\$HOME/.dots/home"
[-d "\$PKGDIR"] || exit 0

find "\$HOME" -type l \
    -lname "*/.dots/home/*" \
    ! -exec test -e {} \; \
    -delete
stow --dir="\$HOME/.dots" --target="\$HOME" home --no-folding
EOF
chmod +x ~/.local/bin/stow-home-sync.sh
systemctl --user daemon-reload
systemctl --user enable --now home-dots-watch.service
