@echo off
setlocal

:: Windows adapter for hook scripts
:: Usage: run-hook.cmd <hook-name>

set "SCRIPT_DIR=%~dp0"
set "HOOK_NAME=%~1"

if "%HOOK_NAME%"=="" (
    echo Error: No hook name provided
    exit /b 1
)

:: Try bash first (Git Bash, WSL, MSYS2)
where bash >nul 2>&1
if %ERRORLEVEL% equ 0 (
    bash "%SCRIPT_DIR%%HOOK_NAME%" %*
    exit /b %ERRORLEVEL%
)

:: Try sh as fallback
where sh >nul 2>&1
if %ERRORLEVEL% equ 0 (
    sh "%SCRIPT_DIR%%HOOK_NAME%" %*
    exit /b %ERRORLEVEL%
)

echo Error: No bash or sh found. Please install Git for Windows or WSL.
exit /b 1
