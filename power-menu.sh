#!/usr/bin/env bash
# 🌿 Jungle Theme Rofi Power Menu for Hyprland

ROFI_THEME="$HOME/.config/rofi/power-menu-jungle.rasi"

chosen=$(echo -e " Lock\n󰍃 Logout\n Reboot\n Shutdown\n Suspend" | rofi -dmenu -i -p "Power Menu" -theme "$ROFI_THEME")

case "$chosen" in
  " Lock") hyprlock ;;
  "󰍃 Logout") hyprctl dispatch exit ;;
  " Reboot") systemctl reboot ;;
  " Shutdown") systemctl poweroff ;;
  " Suspend") systemctl suspend ;;
esac

