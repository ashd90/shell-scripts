#!/usr/bin/env bash
# =====================================================
# 🌈 Colourful Waybar config for Hyprland
# Includes CPU, memory, disk, temperature & power menu
# =====================================================

CONFIG_DIR="$HOME/.config/waybar"
CONFIG_FILE="$CONFIG_DIR/config.jsonc"
STYLE_FILE="$CONFIG_DIR/style.css"
SCRIPTS_DIR="$CONFIG_DIR/scripts"

mkdir -p "$CONFIG_DIR" "$SCRIPTS_DIR"

# -----------------------------------------------------
# Power menu script (uses rofi)
# -----------------------------------------------------
cat > "$SCRIPTS_DIR/power-menu.sh" << 'EOF'
#!/usr/bin/env bash
# Simple power menu using rofi

chosen=$(echo -e " Lock\n󰍃 Logout\n Reboot\n Shutdown\n Suspend" | rofi -dmenu -i -p "Power")

case "$chosen" in
  " Lock") hyprlock ;;
  "󰍃 Logout") hyprctl dispatch exit ;;
  " Reboot") systemctl reboot ;;
  " Shutdown") systemctl poweroff ;;
  " Suspend") systemctl suspend ;;
esac
EOF
chmod +x "$SCRIPTS_DIR/power-menu.sh"

# -----------------------------------------------------
# Waybar JSON configuration
# -----------------------------------------------------
cat > "$CONFIG_FILE" << 'EOF'
{
    "layer": "top",
    "position": "top",
    "height": 30,

    "modules-left": ["hyprland/workspaces", "hyprland/window"],
    "modules-center": ["clock"],
    "modules-right": [
        "cpu",
        "memory",
        "temperature",
        "disk",
        "network",
        "pulseaudio",
        "battery",
        "tray",
        "custom/power"
    ],

    "hyprland/workspaces": {
        "format": "{name}",
        "on-click": "hyprctl dispatch workspace {name}"
    },

    "hyprland/window": {
        "format": "{}"
    },

    "clock": {
        "format": "  {:%a %d %b %H:%M}",
        "interval": 60
    },

    "cpu": {
        "format": "  {usage}%",
        "interval": 5
    },

    "memory": {
        "format": "  {used:0.1f}G",
        "interval": 5
    },

    "temperature": {
        "format": "  {temperatureC}°C",
        "hwmon-path": "/sys/class/thermal/thermal_zone0/temp",
        "critical-threshold": 80
    },

    "disk": {
        "format": "  {free}",
        "path": "/",
        "interval": 60
    },

    "network": {
        "format-wifi": "  {essid}",
        "format-ethernet": "  {ifname}",
        "format-disconnected": "  Disconnected"
    },

    "pulseaudio": {
        "format": "  {volume}%",
        "format-muted": "  Muted",
        "on-click": "pavucontrol"
    },

    "battery": {
        "format": "{icon} {capacity}%",
        "format-icons": ["","","","",""],
        "interval": 60
    },

    "custom/power": {
        "format": "",
        "on-click": "~/.config/waybar/scripts/power-menu.sh",
        "tooltip": false
    },

    "tray": {
        "spacing": 5
    }
}
EOF

# -----------------------------------------------------
# Waybar CSS style — colorful & modern
# -----------------------------------------------------
cat > "$STYLE_FILE" << 'EOF'
/* 🌈 Waybar colorful theme for Hyprland */
* {
    font-family: JetBrainsMono Nerd Font, monospace;
    font-size: 12px;
    color: #e0e0e0;
}

window#waybar {
    background: rgba(25, 25, 35, 0.8);
    border-bottom: 2px solid #89b4fa;
    backdrop-filter: blur(10px);
}

#workspaces button {
    padding: 0 8px;
    margin: 2px;
    border-radius: 6px;
    background: transparent;
    color: #d8dee9;
    transition: background 0.3s;
}

#workspaces button.active {
    background: #89b4fa;
    color: #1e1e2e;
}

#workspaces button:hover {
    background: #b4befe;
    color: #1e1e2e;
}

/* Module colors */
#clock { color: #f9e2af; }
#cpu { color: #a6e3a1; }
#memory { color: #fab387; }
#temperature { color: #f38ba8; }
#disk { color: #94e2d5; }
#network { color: #89dceb; }
#pulseaudio { color: #cba6f7; }
#battery { color: #f2cdcd; }
#battery.charging { color: #a6e3a1; }

#custom-power {
    color: #f38ba8;
    padding: 0 10px;
    border-radius: 6px;
    transition: all 0.2s;
}
#custom-power:hover {
    background-color: #f38ba8;
    color: #1e1e2e;
}

#tray {
    padding-right: 10px;
}

#clock, #network, #pulseaudio, #battery, #tray, #window, #cpu, #memory, #temperature, #disk {
    padding: 0 10px;
}
EOF

# -----------------------------------------------------
# Reload or start Waybar
# -----------------------------------------------------
echo "✅ Colourful Waybar with Power Menu configured!"
echo "📂 Config:  $CONFIG_FILE"
echo "🎨 Style:   $STYLE_FILE"
echo "⚙️  Script:  $SCRIPTS_DIR/power-menu.sh"

if pgrep -x "waybar" > /dev/null; then
    echo "🔁 Reloading Waybar..."
    pkill -SIGUSR2 waybar
else
    echo "🚀 Starting Waybar..."
    waybar &
fi

