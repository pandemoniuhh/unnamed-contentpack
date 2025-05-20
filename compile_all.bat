set "multifile=MadRayneTTCCPack.mf"
set "destination=%localappdata%\Corporate Clash\resources\contentpacks\"

multify -c -f  %multifile% phase_3 phase_3.5 phase_4 phase_5 phase_5.5 phase_6 phase_7 phase_8 phase_9 phase_10 phase_11 phase_12 phase_13 phase_14

move "%multifile%" "%destination%"
