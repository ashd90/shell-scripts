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

PACKAGE_NAME="kubectl" # Replace with the actual package name

case "$DISTRO_ID" in
    ubuntu|debian)
        sudo apt-get update
        sudo apt-get install -y "$PACKAGE_NAME"
        ;;
    fedora|centos|rhel)
        sudo dnf install -y "$PACKAGE_NAME" # Use dnf for modern RHEL-based, yum for older
        ;;
    arch)
        sudo pacman -S --noconfirm "$PACKAGE_NAME"
        ;;
    *)
        echo "Unsupported distribution: $DISTRO_ID. Please install $PACKAGE_NAME manually."
        exit 1
        ;;
esac

if [ $? -eq 0 ]; then
    echo "$PACKAGE_NAME installed successfully."
else
    echo "Failed to install $PACKAGE_NAME."
    exit 1
fi
