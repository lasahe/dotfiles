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
sudo apt install -y tmux vim-tiny
# wget https://raw.githubusercontent.com/lasahe/dotfiles/main/.tmux.conf -O ~/.tmux.conf

# Mount InfoSec folder - https://www.kali.org/docs/virtualization/install-vmware-guest-tools/
# sudo mount-shared-folders
# sudo restart-vm-tools
# ln -s /mnt/hgfs/InfoSec ~/

BLUE "Installing Go..."
sudo apt install -y golang-go
BLUE "Adding GOPATH and GOBIN to .bashrc, so future installs are easy.."
grep "export GOPATH" ~/.bashrc
if [ $? -eq 1 ]
then
   echo "export GOPATH=\$HOME/.go/" >> ~/.bashrc
fi
grep "export GOBIN" ~/.bashrc
if [ $? -eq 1 ]
then
   echo "export GOBIN=\$HOME/.go/bin" >> ~/.bashrc
   echo "export PATH=\$PATH:\$GOBIN" >> ~/.bashrc
fi

BLUE "Installing gobuster..."
sudo apt install -y gobuster

BLUE "Installing Sublime Text..." # according to https://www.sublimetext.com/docs/3/linux_repositories.html-
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
sudo apt-get install -y apt-transport-https
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get update
sudo apt-get install -y sublime-text

BLUE "Setting Keyboard to FI..."
setxkbmap -layout fi 

BLUE "Installing terminator..."
sudo apt install -y terminator

BLUE "Setting terminator as the default terminal emulator..."
sed -i s/Exec=gnome-terminal/Exec=terminator/g /usr/share/applications/xfce4-terminal-emulator.desktop
# sed -i s/Exec=gnome-terminal/Exec=terminator/g /usr/share/applications/xfce4-terminal-emulator.desktop

BLUE "Installing net-tools,rsync,ssh,tcpdump,curl..."
sudo apt install -y net-tools rsync ssh curl tcpdump mtr-tiny

## Sublime keys - Comment & Insert date https://github.com/FichteFoll/InsertDate#readme
### Install Insertdate plugin
### Add to key bindings
[
   { "keys": ["super+shift+k"], "command": "toggle_comment", "args": { "block": false } },
   { "keys": ["shift+alt+d"], "command": "insert_date", "args": {"format": "%d/%m/%Y %I:%M"} }
]
