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
    cp xinitrc /home/$me/.xinitrc
}

install_screenlayout() {
    if [[ ! -d /home/$me/.local/bin ]]; then
        mkdir -p /home/$me/.local/bin
    fi
    cp displays.sh /home/$me/.local/bin/.
}

fix_perms() {
    sudo chown -R $me:$me *
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
    touch /home/$me/.suckless_pkgs
}

setup_wallpaper() {
    cp wallpaper.jpg /home/$me/.wallpaper.jpg
}

############################################################

if [[ ! -f /home/$me/.suckless_pkgs ]]; then
    ensure_packages
fi

install_dwm
install_slstatus
install_rofi_configs
install_xinitrc
install_screenlayout
setup_wallpaper
fix_perms
