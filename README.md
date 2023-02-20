# Suckless

dwm setup

## Versions:
- dwm: 6.3
- slstatus: latest git

## Depends
Various programs are installed using the system's package manager. The script currently only auto-detects `pacman` and `apt`

## Things to change:
* `xinitrc`, since by default it gets copied to `~/`
* `displays.sh`, which you could modify graphically with `arandr`. Or, if you've only got one display, just comment out the `screenlayout` function in `make.sh`
