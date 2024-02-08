title PNG Checker
@ECHO OFF
for /r %%f in (*.png) do (
pngcrush -n -q %%f
)

pause >nul
cmd /k
