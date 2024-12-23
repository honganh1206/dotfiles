#!/bin/bash

# Function to print messages with timestamp
print_message() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1"
}

# Function to check if running as root
check_root() {
    if [ "$EUID" -ne 0 ]; then
        print_message "Please run this script as root or with sudo"
        exit 1
    fi
}

# Function to safely clean apt cache
clean_apt_cache() {
    print_message "Cleaning APT cache..."
    apt-get clean
    apt-get autoremove -y
    apt-get autoclean
}

# Function to remove old kernel versions
# Keeps the current kernel and one previous version for safety
clean_old_kernels() {
    print_message "Removing old kernel versions..."
    current_kernel=$(uname -r | sed 's/-*[a-z].*//g' | sed 's/-$//')
    
    # Remove old kernels but keep the current and previous versions
    dpkg -l 'linux-*' | \
    sed '/^ii/!d;/'"$(uname -r | sed "s/\(.*\)-\([^0-9]\+\)/\1/")"'/d;/\>'"$current_kernel"'/d' | \
    awk '{print $2}' | \
    grep -E "(image|headers)" | \
    xargs apt-get -y purge
}

# Function to clean user cache
clean_user_cache() {
    print_message "Cleaning user cache..."
    # Clean user cache but keep the most recent day's worth
    find /home/*/.cache/ -type f -atime +1 -delete
}

# Function to remove old log files
clean_logs() {
    print_message "Cleaning old log files..."
    # Remove logs older than 30 days
    find /var/log -type f -name "*.log" -mtime +30 -delete
    find /var/log -type f -name "*.log.*" -mtime +30 -delete
}

# Function to clean thumbnail cache
clean_thumbnails() {
    print_message "Cleaning thumbnail cache..."
    rm -rf /home/*/.thumbnails/
    rm -rf /home/*/.cache/thumbnails/
}

# Function to empty trash
empty_trash() {
    print_message "Emptying trash for all users..."
    rm -rf /home/*/.local/share/Trash/*
    rm -rf /root/.local/share/Trash/*
}

# Function to show disk usage before and after cleanup
show_disk_usage() {
    df -h / /home
}

# Main execution
main() {
    print_message "Starting system cleanup..."
    print_message "Disk usage before cleanup:"
    show_disk_usage
    
    check_root
    clean_apt_cache
    clean_old_kernels
    clean_user_cache
    clean_logs
    clean_thumbnails
    empty_trash
    
    print_message "Running final system sync..."
    sync
    
    print_message "Disk usage after cleanup:"
    show_disk_usage
    
    print_message "Cleanup completed successfully!"
}

# Run the script
main
