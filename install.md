sudo pacman -S rofi jq curl
chmod +x setup-waybar.sh
./setup-waybar.sh

# Custome rofi powermenu

# Replace your existing file:
~/.config/waybar/scripts/power-menu.sh


chmod +x ~/.config/waybar/scripts/power-menu.sh


# Create the Rofi theme file

# Path: ~/.config/rofi/power-menu.rasi

Optional: add blur with Hyprland

Add this to your ~/.config/hypr/hyprland.conf for a nice background blur when Rofi opens:

# Blur for rofi
windowrulev2 = blur, class:^(rofi)$
windowrulev2 = opacity 0.9, class:^(rofi)$

