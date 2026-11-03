@echo off
setlocal
rem Compiles and runs the game.
rem Requires a JDK (17+) and the JavaFX SDK. The SDK's "lib" folder is read from the PATH_TO_FX
rem environment variable, or from javafx-path.txt next to this script. If neither is set, the
rem script asks for it once and saves it to javafx-path.txt (ignored by git).
set "FX_FILE=%~dp0javafx-path.txt"

if not defined PATH_TO_FX if exist "%FX_FILE%" set /p PATH_TO_FX=<"%FX_FILE%"
if not defined PATH_TO_FX set /p PATH_TO_FX=Path to the JavaFX SDK "lib" folder:
if not defined PATH_TO_FX goto nofx
set "PATH_TO_FX=%PATH_TO_FX:"=%"
if exist "%PATH_TO_FX%\lib\javafx.controls.jar" set "PATH_TO_FX=%PATH_TO_FX%\lib"
if not exist "%PATH_TO_FX%\javafx.controls.jar" goto badfx
>"%FX_FILE%" echo %PATH_TO_FX%

cd /d "%~dp0TowerDefenseGame_"
javac --module-path "%PATH_TO_FX%" -d bin src\module-info.java src\application\*.java || goto fail
copy /y src\application\*.png bin\application\ >nul
copy /y src\application\*.css bin\application\ >nul

java --module-path "%PATH_TO_FX%;bin" --add-modules javafx.controls,javafx.fxml -m TowerDefenseGame_/application.Game
pause
exit /b 0

:badfx
echo javafx.controls.jar was not found in "%PATH_TO_FX%".
if exist "%FX_FILE%" del "%FX_FILE%"
:nofx
echo Download the JavaFX SDK from https://gluonhq.com/products/javafx/ and enter the path to its "lib" folder.
:fail
pause
exit /b 1
