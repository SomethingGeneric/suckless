#!/usr/bin/env bash
[[ -f ~/.multi ]] && xrandr --output DP-0 --off --output DP-1 --off --output HDMI-0 --off --output DP-2 --mode 1920x1080 --pos 0x0 --rotate normal --output DP-3 --off --output HDMI-1 --off --output DP-4 --mode 1920x1080 --pos 1920x0 --rotate normal --output DP-5 --off
