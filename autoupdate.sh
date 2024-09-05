#!/bin/bash

PURPLE='\033[0;35m'
GREEN='\033[0;32m'
NC='\033[0m'

echo -e "\n${PURPLE}AUS v 1.1${NC}\n"

echo -e "${PURPLE}Updating the Gentoo repo...${NC}\n"
emaint --auto sync

echo -e "${PURPLE}World updating...${NC}\n"
emerge -avuDN --with-bdeps=y @world

echo -e "${PURPLE}Cleaning unnecessary packages${NC}\n"
emerge --depclean

echo -e "${PURPLE}Cleaning source files archives${NC}\n"
eclean-dist --destructive

echo -e "${PURPLE}Cleaning binary packages${NC}\n" 
eclean-pkg --destructive

echo -e "${PURPLE}System was updated successfully ≽^•⩊•^≼ ${NC}\n"

#GRUB update step

echo -e "${GREEN}Update GRUB? y - yes or n - no${NC}"
echo -en "${NC}"
read -p "yes/no: " choose

if [[ "$choose" == 'yes' || "$choose" == 'y' ]]; then
    echo -e "${PURPLE}Updating GRUB...${NC}\n"
    grub-install --efi-directory=/boot
    grub-mkconfig -o /boot/grub/grub.cfg
    echo -e "\n${PURPLE}GRUB was updated${NC}\n"
else 
    echo -e "GRUB update was aborted."
fi

exit 0
