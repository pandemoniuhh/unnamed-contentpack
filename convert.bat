title PNG Cleaner
@ECHO OFF

:confirm
set /P c=Confirm image conversion? [Y/N] 
if /I "%c%" == "Y" goto :action
if /I "%c%" == "N" exit
goto confirm


:action
for /r %%f in (*.png) do (
pngcrush -ow -rem iccp -srgb 1 %%f
)
echo Conversion completed; you may now exit this window
pause >NUL
cmd /k
