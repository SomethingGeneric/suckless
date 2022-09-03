#!/bin/bash

set -e

install_dmenu() {
    pushd dmenu
    sudo make install clean
    popd
}

install_st() {
    pushd st
    sudo make install clean
    popd
}

install_dwm() {
    pushd dwm
    sudo make install clean
    popd
}

install_slstatus() {
    git clone https://github.com/drkhsh/slstatus
    cp slstatus.config.h slstatus/config.h
    pushd slstatus
    sudo make install clean
    popd
    rm -rf slstatus
}

install_xinitrc() {
    cp xinitrc ~/.xinitrc
}


fix_perms() {
    sudo chown -R $USER:$USER *
}

ensure_packages() {
    if [[ -d /etc/pacman.d ]]; then
        mgr="pacman -S --needed --noconfirm"
    elif [[ -d /etc/apt ]]; then
        mgr="apt install -y"
    else
        echo "No idea what distro you're on."
        exit 1
    fi
    sudo ${mgr} git feh flameshot alacritty rofi
}

if [[ ! -f .suckless_pkgs ]]; then
    ensure_packages
fi

install_dwm
install_slstatus
install_xinitrc
fix_perms