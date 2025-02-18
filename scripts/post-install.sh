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
    stow -v --no-folding files
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
    log "Greetd"
    sudo systemctl enable greetd.service
    sudo rm /etc/greetd/config.toml
    sudo ln -s $HOME/.dotfiles/greetd/config.toml /etc/greetd/config.toml 
    log

echo "[Apps] DONE"

echo "[Optimization]"
    ident="  "
    st="p"
    log "Scheduler"
    cat <<EOF > tmp
default_sched = "scx_lavd"
default_mode = auto

[scheds.scx_lavd]
auto_mode = []
gaming_mode = ["--performance"]
lowlatency_mode = ["--performance"]
powersave_mode = ["--powersave"]
EOF
    sudo mkdir -p /etc/scx_loader/
    sudo mv tmp /etc/scx_loader/config.toml
    log

    st="p"
    log "Audio"
    sudo gpasswd -a $USER realtime
    log
echo "[Optimization] DONE"
reboot
