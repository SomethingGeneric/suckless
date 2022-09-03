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

install_screenlayout() {
    if [[ ! -d ~/.local/bin ]]; then
        mkdir -p ~/.local/bin
    fi
    cp displays.sh ~/.local/bin/.
}

fix_perms() {
    sudo chown -R $USER:$USER *
}

ensure_packages() {
    if [[ "$(which sudo)" == "" ]]; then
        echo "Install sudo, please."
        exit 1
    fi

    if [[ -d /etc/pacman.d ]]; then
        mgr="pacman -S --needed --noconfirm"
    elif [[ -d /etc/apt ]]; then
        mgr="apt install -y"
    else
        echo "No idea what distro you're on. Open an issue."
        exit 1
    fi
    sudo ${mgr} git feh flameshot alacritty rofi arandr
    touch ~/.suckless_pkgs
}

setup_wallpaper() {
    cp wallpaper.jpg ~/.wallpaper.jpg
}

if [[ ! -f ~/.suckless_pkgs ]]; then
    ensure_packages
fi

install_dwm
install_slstatus
install_xinitrc
install_screenlayout
setup_wallpaper
fix_perms