#!/bin/bash

# Zuerst das Skript ausführbar machen: chmod +x setup_pi.sh.
# Dann mit sudo ./setup_pi.sh ausführen.

# Logfile für Fehler anlegen
logfile="install_log.txt"
echo "Installation Log - $(date)" >$logfile

# Update und Upgrade
sudo apt update
sudo apt -y upgrade >>$logfile 2>&1

# Funktion zum Prüfen und Installieren von Paketen
install_package() {
  package=$1
  if ! dpkg -s $package >/dev/null 2>&1; then
    echo "Installing $package..."
    sudo apt install -y $package >>$logfile 2>&1
    if [ $? -ne 0 ]; then
      echo "Error installing $package. See $logfile for details."
    fi
  else
    echo "$package is already installed."
  fi
}

# zsh installieren
install_package zsh
chsh -s /bin/zsh >>$logfile 2>&1

# snapd für neovim installieren
install_package snapd

# Skriptverzeichnis erstellen
echo "Making directories for scripts and notebooks..."
mkdir $HOME/scripts
mkdir $HOME/notebooks

# Nerd Fonts installieren
if [ ! -d "/usr/share/fonts/truetype/FiraCode" ]; then
  echo "Installing FiraCode from Nerd Fonts..."
  sudo mkdir /usr/share/fonts/truetype/FiraCode
  curl -fLo "$HOME/Downloads/FiraCode.zip" https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/FiraCode.zip
  sudo unzip /home/ramon/Downloads/FiraCode.zip -d /usr/share/fonts/truetype/FiraCode/ >>$logfile 2>&1
  if [ $? -ne 0 ]; then
    echo "Error installing FiraCode from Nerd Fonts. See $logfile for details."
  fi
  sudo fc-cache -fv >>$logfile 2>&1
else
  echo "FiraCode from Nerd Fonts are already installed."
fi

if [ ! -d "/usr/share/fonts/truetype/SauceCodePro" ]; then
  echo "Installing SauceCodePro from Nerd Fonts..."
  sudo mkdir /usr/share/fonts/truetype/SauceCodePro
  curl -fLo "$HOME/Downloads/SourceCodePro.zip" https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/SourceCodePro.zip
  sudo unzip /home/ramon/Downloads/SourceCodePro.zip -d /usr/share/fonts/truetype/SauceCodePro/ >>$logfile 2>&1
  if [ $? -ne 0 ]; then
    echo "Error installing SauceCodePro from Nerd Fonts. See $logfile for details."
  fi
  sudo fc-cache -fv >>$logfile 2>&1
else
  echo "SauceCodePro from Nerd Fonts are already installed."
fi

if [ ! -d "/usr/share/fonts/truetype/JetBrainsMono" ]; then
  echo "Installing JetBrainsMono from Nerd Fonts..."
  sudo mkdir /usr/share/fonts/truetype/JetBrainsMono
  curl -fLo "$HOME/Downloads/JetBrainsMono.zip" https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip
  sudo unzip /home/ramon/Downloads/JetBrainsMono.zip -d /usr/share/fonts/truetype/JetBrainsMono/ >>$logfile 2>&1
  if [ $? -ne 0 ]; then
    echo "Error installing JetBrainsMono from Nerd Fonts. See $logfile for details."
  fi
  sudo fc-cache -fv >>$logfile 2>&1
else
  echo "JetBrainsMono from Nerd Fonts are already installed."
fi

# Python-Pakete installieren
install_package python3-setuptools
install_package python3-pillow
install_package python3-scipy
install_package python3-notebook
install_package python3-geopy
install_package python3-geopandas
pip install jupyterlab --break-system-packages >>$logfile 2>&1
pip install nbclassic --break-system-packages >>$logfile 2>&1
pip install altair --break-system-packages >>$logfile 2>&1

install_package nodejs
install_package npm

# Github-Cli installieren
echo "Installing Github-Cli"
sudo mkdir -p -m 755 /etc/apt/keyrings
wget -qO- https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg >/dev/null
sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list >/dev/null
sudo apt update
install_package gh

# Nützliche Werkzeuge
install_package mc
mkdir -p $HOME/.local/share/mc/skins && cd $HOME/.local/share/mc/skins && git clone https://github.com/catppuccin/mc.git && ln -s -f ./mc/catppuccin.ini . >>$logfile 2>&1

install_package btop

# bat einrichten
install_package bat
sudo ln -s /usr/bin/batcat ~/.local/bin/bat >>$logfile 2>&1
mkdir -p "$(bat --config-dir)/themes" >>$logfile 2>&1
wget -P "$(bat --config-dir)/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Mocha.tmTheme >>$logfile 2>&1
bat cache --build >>$logfile 2>&1
echo '--theme="Catppuccin Mocha"' >>$HOME/.config/bat/config >>$logfile 2>&1

install_package ripgrep

install_package exa
install_package fzf
install_package fd-find
install_package tmux
install_package wl-clipboard
install_package nala

# LaTeX installieren

install_package texlive
install_package texlive-science
install_package texlive-humanities
install_package texlive-luatex
install_package texlive-latex-extra
install_package texlive-lang-german
install_package texlive-latexmk
install_package csquotes
install_package mathjax-siunitx
install_package pandoc

# Konfigurationsdateien verwalten
echo "Setting up the dotfiles..."
git config --global user.email "ramon.voges@gmail.com"
git config --global user.name "Ramon Voges"
# alias raspi="/usr/bin/git --git-dir=$HOME/.raspi/ --work-tree=$HOME"
# raspi config --local status.showUntrackedFiles no
git clone --bare https://github.com/ramonvoges/raspi.git $HOME/.raspi >>$logfile 2>&1
function raspi {
  /usr/bin/git --git-dir=$HOME/.raspi/ --work-tree=$HOME $@
}
mkdir -p .config-backup >>$logfile 2>&1
raspi checkout
if [ $? = 0 ]; then
  echo "Checked out config."
else
  echo "Backing up pre-existing dot files."
  raspi checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .config-backup/{} >>$logfile 2>&1
fi
raspi checkout >>$logfile 2>&1
raspi config status.showUntrackedFiles no

# Wallpaper kopieren
if [ -f "$HOME/Pictures/background03.png" ]; then
  echo "Copying wallpaper..."
  sudo cp $HOME/Pictures/background03.png /usr/share/rpd-wallpaper/
else
  echo "Wallpaper file not found."
fi

# Theme für btop kopieren
mkdir $HOME/.config/btop/themes/
cp $HOME/Downloads/catppuccin_mocha.theme $HOME/.config/btop/themes/ >>$logfile 2>&1

echo "Installation completed."
