slstatus &
feh --bg-scale .wallpaper.jpg &
if [[ -d .local/bin ]]; then
    ./.local/bin/displays.sh
fi
exec dbus-launch dwm
