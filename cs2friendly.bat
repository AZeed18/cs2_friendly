@echo off
cd /D "%~dp0"
set PATH=%PATH%;C:\Program Files\VPKEdit
busybox64 sh -c ./cs2friendly.sh
