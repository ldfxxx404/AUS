#!/bin/bash

PURPLE='\033[0;35m'
GREEN='\033[0;32m'
NC='\033[0m'

EFI_DIR="/boot"

check_command_success() {
    if [ $? -ne 0 ]; then
        echo -e "${PURPLE}Error: Command failed. Exiting...${NC}"
        exit 1
    fi
}

update_gentoo() {
    echo -e "${PURPLE}Updating the Gentoo repo...${NC}"
    emaint --auto sync
    check_command_success

    echo -e "${PURPLE}World updating...${NC}"
    emerge -avuDN --with-bdeps=y @world
    check_command_success
}

clean_system() {
    echo -e "${PURPLE}Cleaning unnecessary packages${NC}"
    emerge --depclean
    check_command_success

    echo -e "${PURPLE}Cleaning source files archives${NC}"
    eclean-dist --destructive
    check_command_success

    echo -e "${PURPLE}Cleaning binary packages${NC}"
    eclean-pkg --destructive
    check_command_success
}

update_grub() {
    
    if [ "$(id -u)" -ne 0 ]; then
        echo -e "${PURPLE}This script must be run as root to update GRUB.${NC}"
        exit 1
    fi

    echo -e "${PURPLE}Updating GRUB...${NC}"
    grub-install --efi-directory="$EFI_DIR"
    check_command_success

    grub-mkconfig -o /boot/grub/grub.cfg
    check_command_success

    echo -e "${PURPLE}GRUB was updated${NC}"
}

echo -e "\n${PURPLE}AUS v 1.2${NC}\n"

update_gentoo

clean_system

echo -e "${PURPLE}System was updated successfully ≽^•⩊•^≼ ${NC}\n"

echo -e "${GREEN}Update GRUB? y - yes or n - no${NC}"
read -p "yes/no: " choose

if [[ "$choose" =~ ^(yes|y)$ ]]; then
    update_grub
else 
    echo -e "${PURPLE}GRUB update was aborted.${NC}"
fi

exit 0

