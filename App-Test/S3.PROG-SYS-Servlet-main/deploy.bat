@echo off
setlocal enabledelayedexpansion

REM ----------------------------------------------------------
REM deploy.bat - Deploiement de l'application hello.war
REM Destination : C:\Tomcat\webapps
REM ----------------------------------------------------------

REM --- Variables ---
set "APP_NAME=hello"
set "SRC_DIR=src\main\java"
set "WEB_DIR=src\main\webapp"
set "BUILD_DIR=build"
set "LIB_DIR=lib"
set "TOMCAT_WEBAPPS=C:\Tomcat10\apache-tomcat-10.1.24\webapps"

echo.
echo ========================================
echo   Deploiement de l'application %APP_NAME%
echo ========================================
echo.

REM ==========================================================
REM 1. NETTOYAGE
REM ==========================================================

echo [1/6] Nettoyage du repertoire build...

if exist "%BUILD_DIR%" (
    rmdir /s /q "%BUILD_DIR%"
)

mkdir "%BUILD_DIR%\WEB-INF\classes"

if errorlevel 1 (
    echo ERREUR : Impossible de creer le repertoire build.
    pause
    exit /b 1
)

REM ==========================================================
REM 2. COMPILATION JAVA
REM ==========================================================

echo [2/6] Compilation des sources Java...

if not exist "%SRC_DIR%" (
    echo ERREUR : Le repertoire "%SRC_DIR%" n'existe pas.
    pause
    exit /b 1
)

dir /s /b "%SRC_DIR%\*.java" > sources.txt

if not exist sources.txt (
    echo ERREUR : Aucun fichier Java trouve.
    pause
    exit /b 1
)

javac -parameters ^
    -cp "%LIB_DIR%\*" ^
    -d "%BUILD_DIR%\WEB-INF\classes" ^
    @sources.txt

if errorlevel 1 (
    echo.
    echo ERREUR : La compilation a echoue.
    del /q sources.txt 2>nul
    pause
    exit /b 1
)

del /q sources.txt 2>nul

echo Compilation terminee.

REM ==========================================================
REM 3. COPIE DES FICHIERS WEB
REM ==========================================================

echo [3/6] Copie des fichiers web...

if exist "%WEB_DIR%" (
    xcopy "%WEB_DIR%\*" "%BUILD_DIR%\" /E /I /Y >nul

    if errorlevel 1 (
        echo ERREUR : La copie des fichiers web a echoue.
        pause
        exit /b 1
    )
) else (
    echo AVERTISSEMENT : "%WEB_DIR%" n'existe pas.
)

REM --- web.xml ---
if exist "web.xml" (
    mkdir "%BUILD_DIR%\WEB-INF" 2>nul
    copy /Y "web.xml" "%BUILD_DIR%\WEB-INF\" >nul
)

REM --- applicationContext.xml ---
if exist "applicationContext.xml" (
    mkdir "%BUILD_DIR%\WEB-INF" 2>nul
    copy /Y "applicationContext.xml" "%BUILD_DIR%\WEB-INF\" >nul
)

REM ==========================================================
REM 4. COPIE DES LIBRAIRIES
REM ==========================================================

echo [4/6] Copie des librairies...

if exist "%LIB_DIR%\*.jar" (

    mkdir "%BUILD_DIR%\WEB-INF\lib" 2>nul

    copy /Y "%LIB_DIR%\*.jar" "%BUILD_DIR%\WEB-INF\lib\" >nul

    if errorlevel 1 (
        echo ERREUR : Impossible de copier les librairies.
        pause
        exit /b 1
    )

) else (
    echo AVERTISSEMENT : Aucun fichier JAR trouve dans "%LIB_DIR%".
)

REM ==========================================================
REM 5. GENERATION DU WAR
REM ==========================================================

echo [5/6] Generation du fichier %APP_NAME%.war...

pushd "%BUILD_DIR%"

jar -cvf "%APP_NAME%.war" *

if errorlevel 1 (
    popd
    echo ERREUR : La generation du WAR a echoue.
    pause
    exit /b 1
)

popd

if not exist "%BUILD_DIR%\%APP_NAME%.war" (
    echo ERREUR : Le fichier WAR n'a pas ete genere.
    pause
    exit /b 1
)

echo WAR genere :
echo %BUILD_DIR%\%APP_NAME%.war

REM ==========================================================
REM 6. DEPLOIEMENT TOMCAT
REM ==========================================================

echo [6/6] Deploiement vers Tomcat...

if not exist "%TOMCAT_WEBAPPS%" (
    echo ERREUR : Le repertoire "%TOMCAT_WEBAPPS%" n'existe pas.
    pause
    exit /b 1
)

REM Supprime l'ancienne application explosee pour eviter de conserver des JAR obsoletes.
if exist "%TOMCAT_WEBAPPS%\%APP_NAME%" (
    rmdir /s /q "%TOMCAT_WEBAPPS%\%APP_NAME%"
)

copy /Y "%BUILD_DIR%\%APP_NAME%.war" "%TOMCAT_WEBAPPS%\" >nul

if errorlevel 1 (
    echo ERREUR : Impossible de copier le WAR vers Tomcat.
    echo Verifiez que le fichier n'est pas verrouille par Tomcat.
    pause
    exit /b 1
)

echo.
echo ========================================
echo   Deploiement termine avec succes !
echo ========================================
echo.

echo Application :
echo   http://localhost:8080/%APP_NAME%/

echo.
echo Exemple :
echo   http://localhost:8080/%APP_NAME%/hellowrld.lk

echo.
echo Si Tomcat est deja en cours d'execution,
echo il devrait automatiquement redeployer le WAR.

REM Demarre Tomcat lorsque le port HTTP est libre.
powershell -NoProfile -Command "if (-not (Get-NetTCPConnection -LocalPort 8080 -State Listen -ErrorAction SilentlyContinue)) { Start-Process '%TOMCAT_WEBAPPS%\..\bin\startup.bat' -WorkingDirectory '%TOMCAT_WEBAPPS%\..\bin' }"

echo.
echo Pour redemarrer Tomcat :
echo   NET STOP Tomcat
echo   NET START Tomcat

echo.

endlocal
pause