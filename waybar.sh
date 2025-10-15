#!/usr/bin/env bash
# =====================================================
# Default Waybar configuration setup for Hyprland
# =====================================================

CONFIG_DIR="$HOME/.config/waybar"
CONFIG_FILE="$CONFIG_DIR/config.jsonc"
STYLE_FILE="$CONFIG_DIR/style.css"

# Create directory if not exists
mkdir -p "$CONFIG_DIR"

# -----------------------------------------------------
# Write Waybar JSON configuration
# -----------------------------------------------------
cat > "$CONFIG_FILE" << 'EOF'
{
    "layer": "top",
    "position": "top",
    "height": 30,
    "modules-left": ["hyprland/workspaces", "hyprland/window"],
    "modules-center": ["clock"],
    "modules-right": ["network", "pulseaudio", "battery", "tray"],

    "hyprland/workspaces": {
        "format": "{name}",
        "on-click": "hyprctl dispatch workspace {name}"
    },

    "hyprland/window": {
        "format": "{}"
    },

    "clock": {
        "format": "{:%a %d %b %H:%M}",
        "tooltip-format": "<big>{:%Y-%m-%d}</big>",
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
        "format-icons": ["", "", "", "", ""],
        "interval": 60
    },

    "tray": {
        "spacing": 5
    }
}
EOF

# -----------------------------------------------------
# Write Waybar CSS style
# -----------------------------------------------------
cat > "$STYLE_FILE" << 'EOF'
* {
    font-family: JetBrainsMono Nerd Font, monospace;
    font-size: 12px;
    color: #ffffff;
}

window#waybar {
    background-color: rgba(30, 30, 30, 0.85);
    border-bottom: 2px solid #5e81ac;
}

#workspaces button {
    padding: 0 8px;
    margin: 2px;
    border-radius: 6px;
    background-color: transparent;
    color: #ffffff;
}

#workspaces button.active {
    background-color: #5e81ac;
}

#clock, #network, #pulseaudio, #battery, #tray, #window {
    padding: 0 10px;
}

#battery.charging {
    color: #a3be8c;
}
EOF

# -----------------------------------------------------
# Reload or start Waybar
# -----------------------------------------------------
echo "✅ Waybar config created at: $CONFIG_FILE"
echo "✅ Waybar style created at:  $STYLE_FILE"

if pgrep -x "waybar" > /dev/null; then
    echo "🔁 Reloading Waybar..."
    pkill -SIGUSR2 waybar
else
    echo "🚀 Starting Waybar..."
    waybar &
fi

