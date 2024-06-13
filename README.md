# Konfigurationsdateien

In diesem Repo befinden sich meine neuen Dotfiles und Konfigurationsdateien.

## Voraussetzungen

Zuerst müssen die notwendigen Programme installiert werden.

```shell
sudo apt update
sudo apt upgrade
sudo apt install git stow
```

Mit [GNU Stow](https://www.gnu.org/software/stow/) lassen sich Softlinks aus einem Verzeichnis heraus erstellen, so dass Programme und Dateien an einem anderen Ort genutzt werden können.

## Verwendung

Unter `Konfiguration` befinden sich die Dotfiles und Konfigurationsdateien in individuellen Verzeichnissen, damit sie unabhängig voneinander installiert werden können.

Zuerst muss das Repositorium geklont werden:

```shell
git clone ...
cd Konfiguration
```

Anschließend kann mit `stow <Verzeichnis>` die Konfiguration hergestellt werden, die benötigt wird. Mit `stow */` werden alle installiert.

Beispiel für Zshell: `stow zsh`. Das installiert die `.zshrc` im $HOME-Verzeichnis. Für Alacritty: `stow alacritty`. Das linkt die Konfigurationsdateien in `/.config/alacritty/`.
