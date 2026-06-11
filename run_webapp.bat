@echo off
title Etch Rate Predictor Web App

:: Automatically detect if we are inside the EtchRate_WebApp folder or in the parent folder
if exist "%~dp0index.html" (
    set "WEBAPP_DIR=%~dp0"
) else if exist "%~dp0EtchRate_WebApp\index.html" (
    set "WEBAPP_DIR=%~dp0EtchRate_WebApp"
) else (
    echo ========================================================
    echo   ERROR: Could not find index.html!
    echo   Please place this batch file in the root workspace 
    echo   directory or inside the EtchRate_WebApp directory.
    echo ========================================================
    pause
    exit /b
)

echo ========================================================
echo   Launching Etch Rate Predictor Web App...
echo   Serving directory: %WEBAPP_DIR%
echo   Opening browser to: http://localhost:8001
echo ========================================================
echo.
echo Close this command prompt window to stop the web server.
echo.

:: Change directory directly to the target folder to prevent Windows backslash escaping issues in python args
cd /d "%WEBAPP_DIR%"

start "" "http://localhost:8001"
python -m http.server 8001
