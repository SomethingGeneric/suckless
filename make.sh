#!/bin/bash

set -e

build_dmenu() {
    pushd dmenu
    make all
    popd
}

install_dmenu() {
    pushd dmenu
    sudo make install clean
    popd
}

build_st() {
    pushd st
    make all
    popd
}

install_st() {
    pushd st
    sudo make install clean
    popd
}

build_dwm() {
    pushd dwm
    make all
    popd
}

install_dwm() {
    pushd dwm
    sudo make install clean
    popd
}

build_scroll() {
    pushd scroll
    make all
    popd
}

install_scroll() {
    pushd scroll
    sudo make install clean
    popd
}

fix_perms() {
    sudo chown -R $USER:$USER *
}

if [[ "$1" == "install" ]]; then
    install_dmenu
    install_st
    install_scroll
    install_dwm
    fix_perms
elif [[ "$1" == "build" ]]; then
    build_dmenu
    build_st
    build_scroll
    build_dwm
    fix_perms
else
    echo "Usage: $0 [install|build]"
fi