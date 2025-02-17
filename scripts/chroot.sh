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

echo "[Disk]"
    ident="  "
    st="p"
    log "Set disk"
    disk=$(lsblk -no NAME,TYPE | awk '$2 == "disk" && $1 != "loop0" {print "/dev/"$1; exit}')
    if [[ -n $disk ]]; then
        st="da"
        log "$disk" 
    else
        st="e"
        log "$LINENO: Can not find suitable disk"
    fi
echo "[Disk] DONE"

echo "[Localization]"
    ident="  "
    st="p"
    log "Clock"
    ln -sf /usr/share/zoneinfo/Japan /etc/localtime
    hwclock --systohc
    log

    st="p"
    log "Locale"
    echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
    locale-gen>/dev/null
    echo "LANG=en_US.UTF-8" > /etc/locale.conf
    st="da"
    log "en_US"
echo "[Localization] DONE"

echo "[Network]"
    ident="  "
    st="p"
    log "Hostname"
    echo "nowhere" > /etc/hostname
    log

    st="p"
    log "Hosts"
    cat <<EOF > /etc/hosts
127.0.0.1  localhost
::1        localhost ip6-localhost ip6-loopback
ff02::1    ip6-allnodes
ff02::2    ip6-allrouters
127.0.1.1  nowhere
EOF
    log

    st="p"
    log "Enable NetworkManager"
    systemctl enable NetworkManager>/dev/null
    log
echo "[Network] DONE"

echo "[Boot]"
    ident="  "
    st="p"
    log "Bootloader"
    bootctl install >/dev/null
    cat <<EOF > /boot/loader/loader.conf
default                        arch.conf
timeout                        2
console-mode                   auto
editor                         no
EOF
    log

    st="p"
    log "Entries"
    root_part="${disk}2"
    root_uuid=$(blkid -s UUID -o value $root_part)
    cat <<EOF > /boot/loader/entries/arch.conf
title                          Arch Linux
linux                          /vmlinuz-linux
initrd                         /amd-ucode.img
initrd                         /initramfs-linux.img
options                        root=UUID=${root_uuid} rw
EOF
    cat <<EOF > /boot/loader/entries/arch-fallback.conf
title                          Arch Linux (fallback)
linux                          /vmlinuz-linux
initrd                         /amd-ucode.img
initrd                         /initramfs-linux-fallback.img
options                        root=UUID=${root_uuid} rw
EOF
    log
echo "[Boot] DONE"

echo "[Cachyos]"
    ident="  "
    log "Install Cachyos Repo"
    curl -O https://mirror.cachyos.org/cachyos-repo.tar.xz
    tar xvf cachyos-repo.tar.xz && cd cachyos-repo
    ./cachyos-repo.sh
    cd ..

    rm -rf cachyos-repo
    rm cachyos-repo.tar.xz
    pacman -Syu --noconfirm
echo "[Cachyos] DONE"

echo "[Security]"
    ident="  "
    echo "[Password] Root:"
    passwd

    user -m pohlrabi
    echo "[Password] pohlrabi:"
    passwd pohlrabi

    st="p"
    log "Sudoers"
    cat<<EOF > /etc/sudoers
root ALL=(ALL:ALL) ALL
ALL ALL=(ALL:ALL) ALL
EOF
    log

    st="p"
    log "Set fail delay"
    echo "auto optional pam_faildelay.so delay=10000" >> /etc/pam.d/system-login
    log
echo "[Security] DONE"
