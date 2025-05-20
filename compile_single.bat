@echo off
set /p id=Select a phase file to compile (You can also compile subfolder): 

echo Creating...
@echo off
set "filename=phase_%id:/=_%.mf"
multify -c -f %filename% phase_%id%
echo Done.

set "directory=%localappdata%\Corporate Clash\resources\contentpacks\"
echo File created: "%filename%"
echo Destination: "%directory%"

set /p MOVE_CHOICE= Move this file to the contentpacks folder? (Y/any key for N)

If /I "%MOVE_CHOICE%" == "y" (
move "%filename%" "%directory%" ) else ( 
echo Have a nice day
@echo off
@timeout /t 3 >nul )
