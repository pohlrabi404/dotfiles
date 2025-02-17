#!/bin/bash
set -e

# log utils
log="install.log"
ident=""
level="INFO"
st="n" #e:error, n:normal, p:progress, d:done
cache="" #tbh idk if this is a good idea

log() {
    local message=$1
    if [[ "$st" == "p" ]]; then
        st="d"
        cache="$ident [$level] $message"
        printf "$ident [$level] $message ..."
    elif [[ "$st" == "d" ]]; then
        st="n"
        printf "\r$cache   \n" 
    elif [[ "$st" == "da" ]]; then
        st="n"
        printf "\r$cache $message \n" 
    elif [[ "$st" == "e" ]]; then
        printf "\n"
        level="ERROR"
        printf "$ident [$level] $message\n"
        exit 1
    else
        printf "$ident [$level] $message\n"
    fi
}

echo "[Apps]"
    ident="  "
    st="p"
    log "Rebos"
    sudo pacman -S stow --noconfirm
    cat /etc/pacman.conf > tmp
    cat <<EOF >>tmp
[oglo-arch-repo]
SigLevel = Optional DatabaseOptional
Server = https://gitlab.com/Oglo12/\$repo/-/raw/main/\$arch
EOF
    sudo rm -f /etc/pacman.conf
    sudo mv tmp /etc/pacman.conf
    sudo pacman -Syy
    sudo pacman -S rebos --noconfirm

    cd $HOME/.dotfiles
    stow -v files
    rebos setup
    rebos config init
    rebos gen commit "init"
    rebos gen current build
    log

    st="p"
    log "TLDR"
    tldr --update
    log

    st="p"
    log "Scheduler optimization"
    sudo systemctl disable --now ananicy-cpp || true
    sudo dbus-send --system --print-reply --dest=org.scx.Loader /org/scx/Loader org.scx.Loader.StartScheduler string:scx_lavd uint32:0
    log

    st="p"
    log "Setup Zsh"
    chsh -s /usr/bin/zsh
    sudo usermod -a -G wheel,audio,video -s /bin/zsh $USER
    log

    st="p"
    log "Setup Cursors"
    cp -r ./icons $HOME/.local/share
    log

EOF
    sudo rm /etc/environment
    sudo mv tmp /etc/environment
    log
echo "[Apps] DONE"
reboot
