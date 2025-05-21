@echo off
setlocal EnableDelayedExpansion
set /P wantDistributionPayload=<wantDistributionPayload

echo Nai's Ultra Convenient Content Pack and Distribution Batch Script
echo ------------------------------------------------------------------------

set "game_destination=%localappdata%\Corporate Clash\resources\contentpacks\"

set "multifile_name=MadRayneTTCCPack"
set "ext=.mf"
set "compiled_multifile=%multifile_name%%ext%"

rem COMMIT ID APPENDING -----------------------------------------------
for /f %%i in ('git rev-parse --short HEAD') do set "commit=%%i"
set "appended_mf=%multifile_name%_!commit!!ext!"
rem -------------------------------------------------------------------

rem Check if these files exist first before doing anything
if exist "%compiled_multifile%"! (
echo File already compiled!
goto distribute
) else if exist !appended_mf! (
echo File is already set up for distribution.
echo To run this command again, either move, rename, or delete this file.
pause
exit /b
)

:compile
rem I would prefer not to waste disk cycles as much as possible in case of misclicks
pause
multify -c -f %multifile_name%%ext% phase_*

:distribute
if %wantDistributionPayload% == "true" (
set /P "appendPrompt=Compile multifile for distribution? [Y/any for N]"
if "%appendPrompt%" == "y" (
echo commit ID = !commit!
ren "%compiled_multifile%" "!appended_mf!"
echo Commit ID appended and is now ready for distribution.
pause
exit /b)
)
rem goto movefile_distributed)
rem I'm scrapping this, I don't think this is necessary

:movefile
echo Proceeding to move file.
echo Target file = "%compiled_multifile%"
move "%compiled_multifile%" "%game_destination%"
echo All done!
pause
exit /b

rem :movefile_distributed
rem echo Proceeding to move file.
rem echo Target file = !appended_mf!
rem move !appended_mf! "%game_destination%"
rem echo All done!
rem pause

rem If this batch program looks like it was made with the help of ChatGPT, 
rem it's because it was. Mainly the git commit shit
