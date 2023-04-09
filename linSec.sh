#!/bin/bash

# check for directory to install tools, if none, make dir
DIR = "tools"
if [ ! -d "~/$DIR" ]; then
  mkdir ~/$DIR
fi

# install ZSH from repo, set as default shell, copy new profile
sudo apt install zsh
chsh -s $(which zsh)
cp .zshrc ~/

# download the stuff we'll need
curl 'https://portswigger-cdn.net/burp/releases/download?product=community&version=2023.3.2&type=Linux' -o ~/Downloads/burpsuite_community_linux_v2023_3_2.sh
curl https://bootstrap.pypa.io/get-pip.py -o ~/Downloads/get-pip.py
curl https://dl.google.com/go/go1.19.8.linux-amd64.tar.gz -o ~/Downloads/go1.19.8.linux-amd64.tar.gz
curl https://download.oracle.com/java/20/latest/jdk-20_linux-x64_bin.deb -o ~/Downloads/jdk-20_linux-x64_bin.deb

# remove any old installation of golang - unzip & install new
sudo rm -rf /usr/local/go && tar -C /usr/local -xzf ~/Downloads/go1.20.3.linux-amd64.tar.gz

# install jdk-20
sudo dpkg -i ~/Downloads/jdk-20_linux-x64_bin.deb

# remove current java symlink and change to the new JDK version
sudo rm /etc/alternatives/java
sudo ln -s /etc/alternatives/java /usr/lib/jvm/jdk-20/bin/java

# move burp install script to tools dir, and run it
mv ~/Downloads/burpsuite_community_linux_v2023_3_2.sh ~/$DIR
chmod +x ~/$DIR/burpsuite_community_linux_v2023_3_2.sh
~/$DIR/burpsuite_community_linux_v2023_3_2.sh
# rename burpsuite execution file
mv ~/$DIR/BurpSuiteCommunity ~/$DIR/burpsuite

# add burpsuite, go & '~/.local/bin' to PATH
echo "export PATH=$PATH:$HOME/$DIR/BurpSuiteCommunity/:/usr/local/go/bin:$HOME/go/bin/:$HOME/.local/bin:/snap/john-the-ripper/581/run" >> ~/.profile
source ~/.profile

# install gobuster
go install github.com/OJ/gobuster/v3@latest

# install ffuf
go install github.com/ffuf/ffuf/v2@latest

# add repo for latest git release & install git
sudo add-apt-repository ppa:git-core/ppa
sudo apt update
sudo apt install git

# add python-is-python3
sudo apt-get install python-is-python3

# install latest release of pip
python ~/Downloads/get-pip.py

# isntall pwntools & its dependencies
sudo apt-get update
sudo apt-get install python3 python3-pip python3-dev git libssl-dev libffi-dev build-essential
python -m pip install --upgrade pip
python -m pip install --upgrade pwntools

# install flameshot
sudo apt install flameshot
# go to keyboard shortcuts -> add new -> cmd: flameshot gui

# install sqlmap
git clone --depth 1 https://github.com/sqlmapproject/sqlmap.git ~/$DIR/sqlmap-dev

# check for wordlists dir in home directory. if not present, create
if [ ! -d "~/wordlists" ]; then
  mkdir ~/wordlists
fi
git clone https://github.com/danielmiessler/SecLists.git ~/wordlists/SecLists

# install ldapdomaindump
pip install ldap3 dnspython future

git clone https://github.com/dirkjanm/ldapdomaindump.git ~/$DIR/ldapdomaindump
cd ~/$DIR/ldapdomaindump
python setup.py install
cd ~/$DIR

# install crackmapexec
python3 -m pip install pipx
git clone https://github.com/Porchetta-Industries/CrackMapExec ~/$DIR/CrackMapExec
cd ~/$DIR/CrackMapExec
pipx install .

# install john the ripper & metasploit with snap
sudo snap install john-the-ripper
sudo snap install metasploit-framework

# install wireshark & aircrack with apt
sudo apt install wireshark-qt
sudo apt install aircrack-ng
