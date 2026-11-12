@echo off
setlocal EnableExtensions

rem ============================================================
rem Release report generator for FOClassic7
rem Change BRANCH_NAME below when working on another feature branch.
rem TARGET_BRANCH is the branch the PR is intended to merge into.
rem ============================================================

set "BRANCH_NAME=maps_rebuild"
set "TARGET_BRANCH=maps_refactor"

rem Move to the folder containing this .bat file.
cd /d "%~dp0"

echo.
echo ==========================================
echo   FOClassic7 Release Report Generator
echo ==========================================
echo Feature branch: %BRANCH_NAME%
echo Target branch:  %TARGET_BRANCH%
echo.

where git >nul 2>nul
if errorlevel 1 (
    echo ERROR: Git was not found in PATH.
    echo Install Git or open this file from Git Bash / Git CMD setup.
    pause
    exit /b 1
)

git rev-parse --is-inside-work-tree >nul 2>nul
if errorlevel 1 (
    echo ERROR: This .bat file must be placed inside your Git repository.
    echo Current folder: %CD%
    pause
    exit /b 1
)

echo Fetching latest remote branch references...
git fetch origin
if errorlevel 1 (
    echo WARNING: git fetch failed. Continuing with existing remote references.
)

set "BASE=origin/%TARGET_BRANCH%"
set "HEAD=origin/%BRANCH_NAME%"

git rev-parse --verify "%BASE%^{commit}" >nul 2>nul
if errorlevel 1 (
    echo ERROR: Cannot find target branch "%BASE%".
    echo Available remote branches:
    git branch -r
    pause
    exit /b 1
)

git rev-parse --verify "%HEAD%^{commit}" >nul 2>nul
if errorlevel 1 (
    echo ERROR: Cannot find feature branch "%HEAD%".
    echo Available remote branches:
    git branch -r
    pause
    exit /b 1
)

set "REPORT_DIR=release-report"
if not exist "%REPORT_DIR%" mkdir "%REPORT_DIR%"

echo Writing commit list...
git log "%BASE%..%HEAD%" --no-merges --date=short --pretty=format:"%%h - %%ad - %%s" > "%REPORT_DIR%\commits.txt"
if errorlevel 1 (
    echo ERROR: Could not generate commits.txt.
    pause
    exit /b 1
)

echo Writing change summary...
git diff --stat "%BASE%...%HEAD%" > "%REPORT_DIR%\diff-summary.txt"
if errorlevel 1 (
    echo ERROR: Could not generate diff-summary.txt.
    pause
    exit /b 1
)

echo Writing changed-file list...
git diff --name-status "%BASE%...%HEAD%" > "%REPORT_DIR%\changed-files.txt"
if errorlevel 1 (
    echo ERROR: Could not generate changed-files.txt.
    pause
    exit /b 1
)

echo Writing combined report...
(
    echo Release report for %BRANCH_NAME%
    echo Target branch: %TARGET_BRANCH%
    echo Generated on: %DATE% %TIME%
    echo.
    echo ===== COMMITS =====
    git log "%BASE%..%HEAD%" --no-merges --date=short --pretty=format:"%%h - %%ad - %%s"
    echo.
    echo.
    echo ===== CHANGE SUMMARY =====
    git diff --stat "%BASE%...%HEAD%"
    echo.
    echo ===== CHANGED FILES =====
    git diff --name-status "%BASE%...%HEAD%"
) > "%REPORT_DIR%\release-report.txt"

echo.
echo Done. Reports saved in:
echo   %CD%\%REPORT_DIR%
echo.
echo Files:
echo   commits.txt
echo   diff-summary.txt
echo   changed-files.txt
echo   release-report.txt
echo.

notepad "%REPORT_DIR%\release-report.txt"
pause
