#!/bin/bash
set -e

# log utils
log="install.log"
ident=""
level="INFO"
st="n" #e:error, n:normal, p:progress, d:done
cache="" #tbh idk if this is a good idea

is_amd=$(lscpu | grep "Vendor ID" | grep "AMD") || true
is_intel=$(lscpu | grep "Vendor ID" | grep "Intel") || true

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

add_supported_repo() {
    st="p"
    log "Get supported system"
    local supported=$(/lib/ld-linux-x86-64.so.2 --help | grep supported | sed 's/x86-64-\(\w\{2\}\).*$/\1/g')
    local znver_supported=$(gcc -march=native -Q --help=target 2>&1 | head -n 35 | grep -E '(znver4|znver5)')

    local is_v4=$(echo $supported | grep 'v4')
    local is_v3=$(echo $supported | grep 'v3')
    
    cd /dotfiles/scripts
     
    local pacman_conf="/etc/pacman.conf"
    local pacman_conf_c="./pacman.conf"
    local pacman_conf_b="/etc/pacman.conf.bak"

    local isa_level="x86-64-v4"
    local gawk_script="./install-znver4-repo.awk"
    local repo_name="cachyos-znver4"

    if [[ -n $is_v4 ]] && [[ -n $znver_supported ]]; then
        isa_level="x86-64-v4"
        gawk_script="./install-znver4-repo.awk"
        repo_name="cachyos-znver4"
    elif [[ -n $is_v4 ]]; then
        isa_level="x86-64-v4"
        gawk_script="./install-v4-repo.awk"
        repo_name="cachyos-v4"
    elif [[ -n $is_v3 ]]; then
        isa_level="x86-64-v3"
        gawk_script="./install-v3-repo.awk"
        repo_name="cachyos-v3"
    else
        isa_level="x86-64"
        gawk_script="./install-repo.awk"
        repo_name="x86-64"
    fi
    st="da"
    log "$repo_name"

    st="p"
    log "Change config and backup"
    cp $pacman_conf $pacman_conf_c || true
    gawk -i inplace -f $gawk_script $pacman_conf_c || true
    mv $pacman_conf $pacman_conf_b
    mv $pacman_conf_c $pacman_conf
    log

    cd /
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
    echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
    echo "ja_JP.UTF-8 UTF-8" >> /etc/locale.gen
    locale-gen>/dev/null
    echo "LANG=en_US.UTF-8" > /etc/locale.conf
    st="da"
    log "en_US"
echo "[Localization] DONE"

echo "[CachyOS]"
    ident="  "
    st="p"
    log "Add CachyOS signing keys"
    pacman-key --recv-keys F3B607488DB35A47 --keyserver keyserver.ubuntu.com
    pacman-key --lsign-key F3B607488DB35A47
    log

    st="p"
    log "Required packages"
    mirror_url="https://mirror.cachyos.org/repo/x86_64/cachyos"
    pacman -U "${mirror_url}/cachyos-keyring-20240331-1-any.pkg.tar.zst" \
              "${mirror_url}/cachyos-mirrorlist-18-1-any.pkg.tar.zst"    \
              "${mirror_url}/cachyos-v3-mirrorlist-18-1-any.pkg.tar.zst" \
              "${mirror_url}/cachyos-v4-mirrorlist-6-1-any.pkg.tar.zst"  \
              "${mirror_url}/pacman-7.0.0.r6.gc685ae6-2-x86_64.pkg.tar.zst"
    log

    add_supported_repo

    st="p"
    log "Get vendor"

    if [[ -n $is_amd ]]; then
        vendor="amd-ucode"
    elif [[ -n $is_intel ]]; then
        vendor="intel-ucode"
    else
        vendor=""
    fi

    pacman -Syu --noconfirm
    pacman -S paru sudo networkmanager linux-cachyos $vendor --noconfirm

    st="da"
    log "$vendor"

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
    if [[ -n $vendor ]]; then
        vendor_fix="initrd                         /$vendor.img"
    else
        vendor_fix=""
    fi
    cat <<EOF > /boot/loader/entries/arch.conf
title                          Pohlinux 
linux                          /vmlinuz-linux-cachyos
$vendor_fix
initrd                         /initramfs-linux-cachyos.img
options                        root=UUID=${root_uuid} rw
EOF
    cat <<EOF > /boot/loader/entries/arch-fallback.conf
title                          Pohlinux (fallback)
linux                          /vmlinuz-linux-cachyos
$vendor_fix
initrd                         /initramfs-linux-cachyos-fallback.img
options                        root=UUID=${root_uuid} rw
EOF
    log
echo "[Cachyos] DONE"

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

echo "[Security]"
    ident="  "
    echo "[Password] Root:"
    passwd

    useradd -m pohlrabi
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

echo "[Dotfiles]"
    ident="  "
    st="p"
    log "Move dotfiles to home"
    mv /dotfiles /home/pohlrabi/.dotfiles
    chown -R pohlrabi /home/pohlrabi/.dotfiles
    log
echo "[Dotfiles] DONE"
