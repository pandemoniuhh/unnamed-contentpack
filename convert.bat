for /r %%f in (*.png) do (
pngcrush -ow -rem iccp -srgb 1 %%f
)
