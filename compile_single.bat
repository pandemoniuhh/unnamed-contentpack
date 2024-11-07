@echo off
set /p id=Select a phase file to compile: 
echo Creating...
@echo off
multify -c -f phase_%id:/=_%.mf phase_%id%
echo Done.
