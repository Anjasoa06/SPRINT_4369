#!/bin/bash
# À lancer depuis n'importe où : compile le framework, crée framework.jar
# et copie tout ce qu'il faut dans App-Test/lib
set -e
cd "$(dirname "$0")"

# --------------------------
# VARIABLES
# --------------------------
APP_NAME="framework"
SRC_DIR="src"
LIB_DIR="lib"
OUT_DIR="out"
CLASSES_DIR="$OUT_DIR/classes"

# Dossier lib de l'application de test (adapte si tu changes de dossier)
APP_LIB="../App-Test/S3.PROG-SYS-Servlet-main/lib"

trap 'rm -f sources.txt' EXIT

# --------------------------
# NETTOYAGE
# --------------------------
rm -rf "$OUT_DIR"
mkdir -p "$CLASSES_DIR"

# --------------------------
# COMPILATION
# --------------------------
find "$SRC_DIR" -name "*.java" > sources.txt
javac -cp "$LIB_DIR/*" -d "$CLASSES_DIR" @sources.txt

# --------------------------
# CRÉATION DU JAR (uniquement les classes du framework)
# --------------------------
jar -cf "$OUT_DIR/$APP_NAME.jar" -C "$CLASSES_DIR" .
echo "JAR créé : $OUT_DIR/$APP_NAME.jar"

# --------------------------
# COPIE VERS L'APPLICATION DE TEST
# --------------------------
mkdir -p "$APP_LIB"
cp -f "$OUT_DIR/$APP_NAME.jar" "$APP_LIB/Framework.jar"

# Dépendances nécessaires à l'exécution (on saute celles qui posent problème) :
#  - servlet-api.jar : déjà fourni par Tomcat
#  - classgraph.jar  : doublon de classgraph-4.8.179.jar
#  - spring-jcl      : n'existe plus dans Spring 7 (fusionné dans spring-core)
for jar_file in "$LIB_DIR"/*.jar; do
    name="$(basename "$jar_file")"
    case "$name" in
        servlet-api.jar|classgraph.jar|spring-jcl-*) continue ;;
    esac
    cp -f "$jar_file" "$APP_LIB/"
done

echo "Copié dans : $APP_LIB"
echo "Maintenant lance ./deploy.sh dans App-Test."