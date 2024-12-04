@echo off
setlocal enabledelayedexpansion

:: Set the folder where the files are located
set "folder=C:\work\source"

:: Set the path to the search words list
set "searchWordsFile=C:\work\search_words.txt"

:: Set the output text file to save the results
set "outputFile=C:\work\output.txt"

:: Clear the output file at the start (so it doesn't append to an old file)
> "%outputFile%" echo Results of search:

:: Loop through each search word in the search words file
for /f "delims=" %%w in (%searchWordsFile%) do (
    echo Searching for "%%w"...

    :: Search for the word in all files in the folder and append results to the output file
    for /r "%folder%" %%f in (*.*) do (
        findstr /i /m "%%w" "%%f" >nul
        if not errorlevel 1 (
            echo Found "%%w" in: %%f >> "%outputFile%"
        )
    )
)

echo Search complete. Results are saved in "%outputFile%".
endlocal