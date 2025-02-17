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

echo "[Datetime]"

    ident="  "
    st="p"
    log "Syncing datetime"
    timedatectl | grep "synchronized: yes" >/dev/null 2>&1
    if [[ -n $? ]]; then
        log
    else
        st="e"
        log "$LINENO: Sync datetime failed"
    fi

    st="p"
    log "Set timezone"
    timedatectl set-timezone Japan
    if [ $? -eq 0 ]; then
        st="da"
        log "Japan"
    else
        st="e"
        log "$LINENO: Set timezone failed"
    fi
echo "[Datetime] DONE"

echo "[Partition]"

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

    log "Wipe disk..."

        ident="    "
        st="p"
        log "Unmount"
        umount -R /mnt 2>/dev/null || true
        log

        st="p"
        log "Swapoff"
        swapoff "${disk}2" 2>/dev/null || true
        log
         
        st="p"
        log "Wipe partitions"
        wipefs --all --force $disk >/dev/null
        log

    log "DONE"

    ident="  "
    log "Partitioning..."

        ident="    "
        st="p"
        log "Label"
        parted --script $disk mklabel gpt
        log

        st="p"
        log "Boot: 1MiB -> 2GiB"
        parted --script $disk mkpart ESP fat32 1MiB 2GiB >/dev/null
        parted --script $disk set 1 esp on
        mkfs.fat -F 32 "${disk}1"
        log

        st="p"
        log "Root: 2GiB -> 100%%"
        parted --script $disk  mkpart root ext4 2GiB 100%
        mkfs.ext4 -F "${disk}2"
        log

    log "DONE"
echo "[Partition] DONE"

echo "[Mount]"

    ident="  "
    st="p"
    log "Root /mnt"
    mount "${disk}2" /mnt>/dev/null
    log

    st="p"
    log "Boot /mnt/boot"
    mount --mkdir "${disk}1" /mnt/boot>/dev/null
    log
echo "[Mount] DONE"

echo "[Installation]"

    ident="  "
    st="p"
    log "Bootstrap"
    pacstrap -K /mnt base
    log

    st="p"
    log "Fstab"
    genfstab -U /mnt >> /mnt/etc/fstab
    log

    st="p"
    log "Save wifi info"
    cd /var/lib/iwd>/dev/null
    SSID=$(ls *.psk | head -n1 | sed 's/.psk//')>/dev/null
    echo "$SSID" > /mnt/ssid>/dev/null
    cp $SSID.psk /mnt/>/dev/null
    cd
    log

    st="p"
    log "Move scripts"
    mv ~/dotfiles /mnt
    log

    st="p"
    log "Chroot"
    arch-chroot /mnt ./dotfiles/scripts/chroot.sh
    umount -R /mnt
echo "[Installation] DONE"
reboot
