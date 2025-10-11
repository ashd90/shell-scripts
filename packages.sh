#!/bin/bash

if [ -f /etc/os-release ]; then
    . /etc/os-release
    DISTRO_ID=$ID
else
    # Fallback for older systems or if /etc/os-release is not present
    if command -v apt-get &> /dev/null; then
        DISTRO_ID="debian"
    elif command -v yum &> /dev/null; then
        DISTRO_ID="rhel" # Or fedora, centos, etc.
    elif command -v dnf &> /dev/null; then
        DISTRO_ID="fedora"
    elif command -v pacman &> /dev/null; then
        DISTRO_ID="arch"
    else
        echo "Could not determine distribution. Exiting."
        exit 1
    fi
fi

echo "Detected distribution: $DISTRO_ID"


# ... (distribution identification code from above) ...

read -p "Enter the packages: " user_packages

case "$DISTRO_ID" in
    ubuntu|debian)
        sudo apt-get update
        sudo apt-get install -y $user_packages
        ;;
    fedora|centos|rhel)
        sudo dnf install -y $user_packages # Use dnf for modern RHEL-based, yum for older
        ;;
    arch)
        sudo pacman -S --noconfirm $user_packages --needed
        ;;
    *)
        echo "Unsupported distribution: $DISTRO_ID. Please install $user_packages manually."
        exit 1
        ;;
esac

if [ $? -eq 0 ]; then
    echo "$user_packages installed successfully."
else
    echo "Failed to install $user_packages."
    exit 1
fi
