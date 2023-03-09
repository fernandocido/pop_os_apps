#!/bin/bash

##### List of Apps
LIST_OF_APPS=(
	android-studio
	arduino
	arduino-avr-core
	audacity
	chromium
	cmatrix
	cowsay
	discord
	fortune
	gimp
	google-chrome
	htop
	inkscape
	neofetch
	notepadqq
	notion
	obs-studio
	papirus-icon-theme
	piper
	signal
	spotify
	steam
	telegram-desktop
	terminus-font
	tree
	trello
	virtualbox
	visual-studio-code
	vlc
	zsh
	zsh-completions
	zsnes
	)

##### Check if needed
# cheese
# firefox
# gnome-sushi

##### KDE apps
# okular
# spectacle

##### Variables
DOWNLOADS_FOLDER="$HOME/Downloads/apps_shell_script"

URL_PI="https://download.opensuse.org/repositories/home:/pragmalin/xUbuntu_22.04/amd64/rpi-imager_1.7.4_amd64.deb"
URL_SAFING="https://updates.safing.io/latest/linux_amd64/packages/portmaster-installer.deb"
URL_SLACK="https://downloads.slack-edge.com/releases/linux/4.29.149/prod/x64/slack-desktop-4.29.149-amd64.deb"

GREEN='\e[1;92m'
NO_COLOR='\e[0m'

##### Functions
# sudo apt-get a life!
apt_update(){
	sudo flatpak update -y
	sudo apt-get update -y
	sudo apt-get autoclean -y && sudo apt-get autoremove -y
	clear && fortune | cowsay
}

install_apps(){

	echo -e "${GREEN}[INFO] - Downloading Packages .deb${NO_COLOR}"

	mkdir "$DOWNLOADS_FOLDER"
	wget -c "$URL_SAFING" -P "$DOWNLOADS_FOLDER"

	echo -e "${GREEN}[INFO] - Installing .debs ${NO_COLOR}"
	sudo dpkg -i $DOWNLOADS_FOLDER/*.deb

	echo -e "${GREEN}[INFO] - Installing flatpaks${NO_COLOR}"
	flatpak install flathub com.bitwarden.desktop -y

	echo -e "${GREEN}[INFO] - Installing apts${NO_COLOR}"

	for app_name in ${LIST_OF_APPS[@]}; do
	  if ! dpkg -l | grep -q $app_name; then # install only if not installed
	    sudo apt-get install "$app_name" -y
	  else
	    echo "[INSTALLED] - $app_name"
	  fi
	done

}

##### DO IT!

install_apps
apt_update

echo -e "${GREEN}[INFO] - Done :)${NO_COLOR}"
