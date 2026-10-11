#!/bin/bash
# Arrête le script à la première erreur (plus de "Déploiement terminé" si ça a planté)
set -e
cd "$(dirname "$0")"

# --------------------------
# VARIABLES
# --------------------------
APP_NAME="apk"
SRC_DIR="src/main/java"
WEB_DIR="src/main/webapp"
BUILD_DIR="build"
LIB_DIR="lib"
TOMCAT_HOME="/home/anjasoa/Documents/tomcat-11"
TOMCAT_WEBAPPS="$TOMCAT_HOME/webapps"
# servlet-api.jar est fourni par Tomcat : on s'en sert seulement pour COMPILER
SERVLET_API_JAR="$TOMCAT_HOME/lib/servlet-api.jar"

if [ ! -f "$SERVLET_API_JAR" ]; then
    echo "ERREUR : $SERVLET_API_JAR introuvable (vérifie TOMCAT_HOME)."
    exit 1
fi

trap 'rm -f sources.txt' EXIT

# --------------------------
# NETTOYAGE
# --------------------------
rm -rf "$BUILD_DIR"
mkdir -p "$BUILD_DIR/WEB-INF/classes"
mkdir -p "$BUILD_DIR/WEB-INF/lib"

# --------------------------
# COMPILATION
# --------------------------
# -parameters : indispensable, sinon getName() renvoie arg0, arg1...
# -cp "lib/*:servlet-api.jar" : tous les jars de lib/ + l'API servlet
find "$SRC_DIR" -name "*.java" > sources.txt
javac -parameters \
      -cp "$LIB_DIR/*:$SERVLET_API_JAR" \
      -d "$BUILD_DIR/WEB-INF/classes" \
      @sources.txt

# --------------------------
# FICHIERS WEB
# --------------------------
cp -r "$WEB_DIR"/* "$BUILD_DIR/"
cp -f web.xml "$BUILD_DIR/WEB-INF/"

# Config Spring (selon ton web.xml, elle doit être à l'un de ces deux endroits)
if [ -f applicationContext.xml ]; then
    cp -f applicationContext.xml "$BUILD_DIR/WEB-INF/"
    cp -f applicationContext.xml "$BUILD_DIR/WEB-INF/classes/"
fi

# --------------------------
# LIBRAIRIES DANS LE .WAR
# --------------------------
cp -f "$LIB_DIR"/*.jar "$BUILD_DIR/WEB-INF/lib/"

# Spring a besoin de spring-jcl pour charger org.apache.commons.logging.LogFactory.
# Si la librairie n'est pas déjà présente dans le projet web, on la récupère depuis le framework voisin.
for jar_file in \
    "../../Framework/lib/spring-jcl"*.jar \
    "../../Framework/build/lib/spring-jcl"*.jar; do
    if [ -f "$jar_file" ]; then
        cp -f "$jar_file" "$BUILD_DIR/WEB-INF/lib/"
    fi
done

# Tomcat a déjà son servlet-api : ne jamais le mettre dans le .war
rm -f "$BUILD_DIR/WEB-INF/lib/servlet-api.jar"

# --------------------------
# CRÉATION DU .WAR
# --------------------------
jar -cf "$APP_NAME.war" -C "$BUILD_DIR" .
mv -f "$APP_NAME.war" "$BUILD_DIR/"

# --------------------------
# DÉPLOIEMENT
# --------------------------
rm -rf "$TOMCAT_WEBAPPS/$APP_NAME"          # ancien dossier décompressé
cp -f "$BUILD_DIR/$APP_NAME.war" "$TOMCAT_WEBAPPS/"

echo ""
echo "Déploiement terminé. Redémarrez Tomcat si nécessaire."
echo ""