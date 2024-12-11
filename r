Hier ist eine detaillierte Erklärung, was Sie bei jedem Schritt tun sollten:

1. Legen Sie sich ein Arbeitsverzeichnis an
Öffnen Sie das Terminal in der VM.
Erstellen Sie ein Verzeichnis in Ihrem Home-Ordner, z. B. Arbeitsverzeichnis:
bash
Code kopieren
mkdir ~/Arbeitsverzeichnis
Wechseln Sie in dieses Verzeichnis:
bash
Code kopieren
cd ~/Arbeitsverzeichnis
2. Kopieren Sie sich die Vorgabe-Dateien in Ihren Ordner
Navigieren Sie zum angegebenen Pfad, der die Vorgabedateien enthält:
bash
Code kopieren
cd /data/mirolab
Kopieren Sie die Dateien in Ihr Arbeitsverzeichnis:
bash
Code kopieren
cp -r * ~/Arbeitsverzeichnis
Wechseln Sie zurück in Ihr Arbeitsverzeichnis:
bash
Code kopieren
cd ~/Arbeitsverzeichnis
3. Installieren Sie wikit
Wikit ist ein Node.js-basiertes Tool, daher benötigen Sie npm. Installieren Sie es mit apt:
bash
Code kopieren
sudo apt update
sudo apt install npm -y
Installieren Sie anschließend wikit mit npm:
bash
Code kopieren
sudo npm install -g wikit
Überprüfen Sie, ob die Installation erfolgreich war:
bash
Code kopieren
wikit --help
4. Lesen Sie sich in das Tool ein und probieren Sie es aus
Verwenden Sie wikit, um das Tool kennenzulernen. Beispielsweise können Sie Informationen zu einem Begriff abrufen:
bash
Code kopieren
wikit Linux
Notieren Sie sich, wie Sie den Befehl verwenden können, um Artikel herunterzuladen und Optionen (z. B. Sprache) anzupassen.
5. Schreiben Sie ein Bash-Skript, das Ihre Interessensliste Zeile für Zeile durchläuft
Erstellen Sie ein Bash-Skript, z. B. wido.sh:
bash
Code kopieren
nano wido.sh
Das Skript soll eine Datei (z. B. meineInteressen.txt) einlesen und jede Zeile durchlaufen. Verwenden Sie dazu eine Schleife:
bash
Code kopieren
while IFS= read -r line; do
  echo "Bearbeite: $line"
  # Weitere Schritte folgen
done < "$1"
6. Ihr Programm sollte mit der Interessensliste als Parameter aufgerufen werden
Testen Sie das Skript, indem Sie es mit der Interessensliste aufrufen:
bash
Code kopieren
./wido.sh meineInteressen.txt
Stellen Sie sicher, dass das Skript die Datei richtig liest und verarbeitet.
7. Geben Sie Zwischenmeldungen aus
Fügen Sie Debugging-Informationen hinzu, um zu sehen, was das Skript gerade tut. Zum Beispiel:
bash
Code kopieren
echo "Lade Artikel für: $line herunter"
Bei Fehlern geben Sie eine klare Fehlermeldung aus:
bash
Code kopieren
if ! wikit "$line"; then
  echo "Fehler beim Laden von: $line" >&2
fi
8. Nutzen Sie den wikit-Befehl, um die Artikel herunterzuladen
Fügen Sie den wikit-Befehl in Ihre Schleife ein, um die Artikel zu laden:
bash
Code kopieren
content=$(wikit "$line")
Speichern Sie den Inhalt in einer Datei.
9. Für jeden Artikel eine Datei erstellen
Erstellen Sie einen Ordner, in dem die Artikel gespeichert werden:
bash
Code kopieren
mkdir -p Lesestoff
Speichern Sie jeden Artikel in einer Datei mit dem Artikelnamen:
bash
Code kopieren
echo "$content" > "Lesestoff/$line.txt"
10. Artikel auf Deutsch herunterladen
Passen Sie den wikit-Befehl so an, dass die Artikel auf Deutsch heruntergeladen werden. Dazu verwenden Sie die Option -lang:
bash
Code kopieren
content=$(wikit -lang de "$line")
Nach diesen Schritten sollte Ihr Bash-Skript fertig sein. Es liest die Interessensliste ein, lädt die entsprechenden Artikel auf Deutsch herunter und speichert sie in Dateien im Ordner Lesestoff.
