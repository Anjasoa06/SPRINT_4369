#!/bin/bash

# Se placer dans le dossier du script
cd "$(dirname "$0")" || exit 1

# --------------------------
# VARIABLES
# --------------------------
APP_NAME="framework"
SRC_DIR="src"
OUT_DIR="out"
CLASSES_DIR="$OUT_DIR/classes"
LIB_DIR="$OUT_DIR/lib"
LIB="lib"

echo
echo "==================================="
echo "Nettoyage..."
echo "==================================="

# Supprimer l'ancien dossier out
rm -rf "$OUT_DIR"

# Créer les dossiers
mkdir -p "$CLASSES_DIR"
mkdir -p "$LIB_DIR"

echo
echo "==================================="
echo "Compilation Java..."
echo "==================================="

# Créer la liste des fichiers Java
find "$SRC_DIR" -name "*.java" > /tmp/sources.txt

# Compiler
javac -cp "$LIB/*" -d "$CLASSES_DIR" @/tmp/sources.txt

RESULT=$?

# Supprimer le fichier temporaire
rm -f /tmp/sources.txt

if [ $RESULT -ne 0 ]; then
    echo
    echo "ERREUR : Compilation echouee."
    exit 1
fi

echo
echo "==================================="
echo "Copie des JARs dependances..."
echo "==================================="

# Copier les JARs de lib vers out/lib
for jar_file in "$LIB"/*.jar; do
    if [ -f "$jar_file" ]; then
        echo "Copie de $(basename "$jar_file")"
        cp -f "$jar_file" "$LIB_DIR/"
    fi
done

echo
echo "==================================="
echo "Creation du $APP_NAME.jar..."
echo "==================================="

# Créer le JAR à partir des classes compilées
jar cf "$LIB_DIR/$APP_NAME.jar" -C "$CLASSES_DIR" .

if [ $? -ne 0 ]; then
    echo "ERREUR : Creation du JAR impossible."
    exit 1
fi

echo
echo "JAR cree :"
echo "  $LIB_DIR/$APP_NAME.jar"

echo
echo "==================================="
echo "BUILD TERMINE avec succes !"
echo "==================================="