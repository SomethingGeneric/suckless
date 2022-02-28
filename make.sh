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
    git clone https://git.tar.black/matt/slstatus
    cp slstatus.config.h slstatus/config.h
    pushd slstatus
    sudo make install clean
    popd
    rm -rf slstatus
}


fix_perms() {
    sudo chown -R $USER:$USER *
}


install_dmenu
install_st
install_dwm
install_slstatus
fix_perms