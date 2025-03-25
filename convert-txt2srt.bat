
set DIR=2025\03\23

set INPUT_FILE=%DIR%\2025-03-23-jp.txt
set OUTPUT_FILE=%DIR%\2025-03-23-jp.srt.tmp

type nul > "%OUTPUT_FILE%"

set "firstLineDone=0"
set count=1

for /f "usebackq tokens=1,* delims=' '" %%A in ("%INPUT_FILE%") do (
    if %firstLineDone%==0 (
        set "prevTimestamp=%%A"
        set "prevText=%%B"
        set firstLineDone=1
    ) else (
        set /a count+=1
        >> "%OUTPUT_FILE%" echo %count%
        >> "%OUTPUT_FILE%" echo "%prevTimestamp% --> %%A"
        >> "%OUTPUT_FILE%" echo %prevText%
        >> "%OUTPUT_FILE%" echo.
        set "prevTimestamp=%%A"
        set "prevText=%%B"
    )
)

if defined prevTimestamp (
    set /a count+=1
    >> "%OUTPUT_FILE%" echo %count%
    >> "%OUTPUT_FILE%" echo "%prevTimestamp% -->"
    >> "%OUTPUT_FILE%" echo %prevText%
    >> "%OUTPUT_FILE%" echo.
)

echo done
pause