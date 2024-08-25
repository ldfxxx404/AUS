#!/bin/bash

PURPLE='\033[0;35m'
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
