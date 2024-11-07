#!/bin/bash

# Function to create a new user
create_user() {
    read -p "Enter username: " username
    read -p "Enter home directory (press Enter to use default): " home_dir
    read -p "Enter shell (press Enter to use default /bin/bash): " shell
    shell=${shell:-/bin/bash}

    # Check if user already exists
    if id "$username" &>/dev/null; then
        echo "User $username already exists."
        return
    fi

    # Create user
    if [ -z "$home_dir" ]; then
        useradd -m -s "$shell" "$username"
    else
        useradd -m -d "$home_dir" -s "$shell" "$username"
    fi

    # Set password for user
    echo "Set password for $username."
    passwd "$username"
}

# Function to delete a user
delete_user() {
    read -p "Enter username to delete: " username

    # Check if user exists
    if id "$username" &>/dev/null; then
        userdel -r "$username"
        echo "User $username deleted successfully."
    else
        echo "User $username does not exist."
    fi
}

# Function to list all users
list_users() {
    echo "Listing all users:"
    cut -d: -f1 /etc/passwd
}

# Main menu
while true; do
    echo "User Management System"
    echo "1. Create User"
    echo "2. Delete User"
    echo "3. List Users"
    echo "4. Exit"
    read -p "Choose an option [1-4]: " choice

    case "$choice" in
        1) create_user ;;
        2) delete_user ;;
        3) list_users ;;
        4) echo "Exiting..." ; exit 0 ;;
        *) echo "Invalid option, please try again." ;;
    esac
    echo
done
