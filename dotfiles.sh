#!/bin/bash

# Define colors...
RED=`tput bold && tput setaf 1`
GREEN=`tput bold && tput setaf 2`
YELLOW=`tput bold && tput setaf 3`
BLUE=`tput bold && tput setaf 4`
NC=`tput sgr0`

function RED(){
   echo -e "\n${RED}${1}${NC}"
}
function GREEN(){
   echo -e "\n${GREEN}${1}${NC}"
}
function YELLOW(){
   echo -e "\n${YELLOW}${1}${NC}"
}
function BLUE(){
   echo -e "\n${BLUE}${1}${NC}"
}

# Testing if root...
if [ $UID -ne 0 ]
then
   RED "You must run this script as root!" && echo
   exit
fi

# Get .tmux conf
BLUE "Installing Tmux,vim..."
sudo apt install -y tmux vim

## Install tmux config
wget https://raw.githubusercontent.com/lasahe/dotfiles/main/.tmux.conf -O ~/.tmux.conf

BLUE "Setting Keyboard to FI..."
setxkbmap -layout fi 

BLUE "Installing net-tools,ssh,tcpdump,curl..."
sudo apt install -y net-tools ssh curl tcpdump mtr-tiny

BLUE "Installing terminator..."
sudo apt install -y terminator

# Change terminator as default terminal
# sudo update-alternatives --config x-terminal-emulator
