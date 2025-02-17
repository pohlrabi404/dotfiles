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

# echo "[Network]"
#     ident="  "
#     st="p"
#     log "Reconnect previous connection"
#     cd /
#     SSID=$(ls | grep ".psk" | sed "s/.psk//")
#     psk_file="/$SSID.psk"
#     password=$(sudo grep 'Passphrase=' "$psk_file" | cut -d= -f2)
#     until nmcli -t -f STATE general | grep -q "connected"; do
#         sleep 2
#     done
#     nmcli device wifi connect "$SSID" password "$password"
#     st="da"
#     log "$SSID"
#
#     st="p"
#     log "Remove old connetion file"
#     rm $psk_file
#     log
#
# echo "[Network] DONE"

echo "[Apps]"
    ident="  "
    st="p"
    log "Rebos"
    sudo pacman -S stow
    cat /etc/pacman.conf > tmp
    cat <<EOF >>tmp
[oglo-arch-repo]
SigLevel = Optional DatabaseOptional
Server = https://gitlab.com/Oglo12/\$repo/-/raw/main/\$arch
EOF
    sudo rm -f /etc/pacman.conf
    sudo mv tmp /etc/pacman.conf
    sudo pacman -Syy
    sudo pacman -S rebos

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

    st="p"
    log "Anyrun"
    rm -r /etc/anyrun
    log

    st="p"
    log "Yazi theme"
    ya pack -a bennyyip/gruvbox-dark
    log

    st="p"
    log "Language input"
    cat /etc/environment > tmp
    cat <<EOF >> tmp 
    GTK_IM_MODULE=fcitx
    QT_IM_MODULE=fcitx
    XMODIFIERS=@im=fcitx
EOF
    sudo rm /etc/environment
    sudo mv tmp /etc/environment
    log
echo "[Apps] DONE"
reboot
