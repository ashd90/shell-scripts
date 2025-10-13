#!/bin/bash

echo "Please choose an option:"
echo "1. Display current date and time"
echo "2. List files in current directory"
echo "3. Print system uptime"
echo "4. Print system information"
echo "5. Exit"

read -p "Enter your choice (1-4): " choice

case $choice in
    1)
        echo "Current date and time: $(date)"
        ;;
    2)
        echo "Files in current directory:"
        ls -l
        ;;
    3)
        echo "System uptime:"
        uptime
        ;;
    4)
        echo "System information."
        fastfetch
        ;;
    5)
        echo "Exiting script."
        exit 0
        ;;

    *)
        echo "Invalid choice. Please enter a number between 1 and 4."
        ;;
esac
