# Python-Bibliotheken für den Raspberry Pi 5

Dieses Verzeichnis enthält eine Liste der Python-Bibliotheken, die für die Verwendung auf dem Raspberry Pi 5 installiert sind. Die Liste wurde mit dem Befehl `pip freeze` erstellt und in der Datei `raspi_requirements.txt` gespeichert.

## Installation

Um die gleichen Python-Bibliotheken auf einem anderen System zu installieren, führe den folgenden Befehl aus:

```bash
pip install -r raspi_requirements.txt
```

Dieser Befehl liest die `raspi_requirements.txt`-Datei und installiert alle darin aufgeführten Python-Pakete mit den angegebenen Versionen.

## Aktualisieren der Bibliotheksliste

Wenn Du neue Python-Bibliotheken auf Ihrem Raspberry Pi 5 installierst oder vorhandene aktualisierst, musst Du die `raspi_requirements.txt`-Datei aktualisieren. Führe dazu den folgenden Befehl aus:

```bash
pip freeze > raspi_requirements.txt
```

Dieser Befehl überschreibt die bestehende `raspi_requirements.txt`-Datei mit einer aktualisierten Liste aller installierten Python-Pakete und deren Versionen.

## Hinweise

- Stelle sicher, dass Du die `raspi_requirements.txt`-Datei auf demselben System erstellst, auf dem die Python-Bibliotheken installiert sind, die Du aufzeichnen möchtest.
- Beachte, dass die Installation von Bibliotheken mit `pip install -r` möglicherweise Konflikte mit bereits installierten Paketen verursachen kann. In diesem Fall musst Du die Konflikte manuell auflösen oder eine virtuelle Umgebung verwenden.
- Wenn Du eine virtuelle Umgebung verwendest, musst Du die `raspi_requirements.txt`-Datei innerhalb dieser Umgebung erstellen und installieren.
