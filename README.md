Hier ist ein Vorschlag, wie die beiden Shell-Skripte encrypt.sh und restore.sh erstellt werden können, um die beschriebenen Anforderungen zu erfüllen:

1. encrypt.sh – Verschlüsseln der Bilder
Das Skript iteriert über alle Bilder in einem angegebenen Ordner, verschlüsselt sie mithilfe von gpg, und löscht die Originaldateien. Es überprüft außerdem, dass die Skripte selbst nicht versehentlich verschlüsselt werden.

bash
Code kopieren
#!/bin/bash

# Ordner, der die Bilder enthält
IMAGE_DIR="bilder"
# Public Key ID (setzen Sie hier Ihren eigenen Key ein)
KEY_ID="Ihr_Public_Key_ID"

# Schleife über alle Dateien im Ordner
for file in "$IMAGE_DIR"/*; do
    # Überspringen, falls die Datei ein Skript ist
    if [[ "$file" == *encrypt.sh || "$file" == *restore.sh ]]; then
        echo "Überspringe Skript-Datei: $file"
        continue
    fi

    # Dateinamen ausgeben
    echo "Verarbeite Datei: $file"

    # Datei mit gpg verschlüsseln
    gpg --output "$file.gpg" --encrypt --recipient "$KEY_ID" "$file"

    # Prüfen, ob die Verschlüsselung erfolgreich war
    if [[ $? -eq 0 ]]; then
        echo "Datei verschlüsselt: $file.gpg"
        # Originaldatei löschen
        rm "$file"
    else
        echo "Fehler beim Verschlüsseln: $file"
    fi
done
2. restore.sh – Entschlüsseln der Bilder
Das Skript iteriert über alle .gpg-Dateien im Ordner, entschlüsselt sie zurück in ihre ursprüngliche Form, und löscht die verschlüsselten Dateien.

bash
Code kopieren
#!/bin/bash

# Ordner, der die verschlüsselten Bilder enthält
IMAGE_DIR="bilder"

# Schleife über alle verschlüsselten Dateien im Ordner
for file in "$IMAGE_DIR"/*.gpg; do
    # Dateinamen ausgeben
    echo "Verarbeite Datei: $file"

    # Datei mit gpg entschlüsseln
    gpg --output "${file%.gpg}" --decrypt "$file"

    # Prüfen, ob die Entschlüsselung erfolgreich war
    if [[ $? -eq 0 ]]; then
        echo "Datei entschlüsselt: ${file%.gpg}"
        # Verschlüsselte Datei löschen
        rm "$file"
    else
        echo "Fehler beim Entschlüsseln: $file"
    fi
done
Hinweise:
Schlüsselgenerierung
Sie können einen neuen Schlüssel mit folgendem Befehl erstellen:

bash
Code kopieren
gpg --full-generate-key
Wählen Sie dabei:

RSA- und RSA-Schlüssel (Option 1).
Schlüssellänge: 4096 Bit.
Gültigkeitsdauer: 6 Monate.
Benutzer-ID: Vor- und Nachname (z. B. Max Mustermann).
Fehlerbehandlung und Backups
Fügen Sie am besten eine zusätzliche Sicherung der Skripte ein, damit diese nicht versehentlich gelöscht oder verschlüsselt werden.

Testen
Testen Sie die Skripte zuerst mit Testbildern in einem separaten Ordner, bevor Sie echte Bilder verarbeiten.
