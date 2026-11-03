@echo off
rem Compiles and runs the game.
rem Requires a JDK (17+) and the JavaFX SDK. Set PATH_TO_FX to the SDK's "lib" folder first, e.g.
rem   set PATH_TO_FX=C:\javafx-sdk-17.0.15\lib
cd /d "%~dp0TowerDefenseGame_"

if "%PATH_TO_FX%"=="" (
    echo PATH_TO_FX is not set. Point it to the "lib" folder of your JavaFX SDK.
    pause
    exit /b 1
)

javac --module-path "%PATH_TO_FX%" -d bin src\module-info.java src\application\*.java || (pause & exit /b 1)
copy /y src\application\*.png bin\application\ >nul
copy /y src\application\*.css bin\application\ >nul

java --module-path "%PATH_TO_FX%;bin" --add-modules javafx.controls,javafx.fxml -m TowerDefenseGame_/application.Game

pause
