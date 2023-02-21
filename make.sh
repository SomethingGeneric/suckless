#!/usr/bin/env bash

set -e

me="matt"

install_dwm() {
    pushd dwm
    sudo make install clean
    popd
}

install_slstatus() {
	if [[ -d slstatus ]]; then
		pushd slstatus && git pull && popd
	else
    	git clone https://github.com/SomethingGeneric/slstatus
	fi
    cp slstatus.config.h slstatus/config.h
    pushd slstatus
    sudo make install clean
    popd
    rm -rf slstatus
}

install_rofi_configs() {
	if [[ ! -d rofi ]]; then
		git clone --depth=1 https://github.com/adi1090x/rofi.git
	else
		pushd rofi && git pull && popd
	fi
	pushd rofi
	chmod +x setup.sh
	su $me -c "./setup.sh"
	sed -i "s/'style-1'/'style-4'/g" /home/$me/.config/rofi/launchers/type-6/launcher.sh
	popd
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
    sudo ${mgr} git feh flameshot alacritty rofi arandr xorg xorg-xinit
    touch ~/.suckless_pkgs
}

setup_wallpaper() {
    cp wallpaper.jpg ~/.wallpaper.jpg
}

############################################################

if [[ ! -f ~/.suckless_pkgs ]]; then
    ensure_packages
fi

install_dwm
install_slstatus
install_rofi_configs
install_xinitrc
install_screenlayout
setup_wallpaper
fix_perms
