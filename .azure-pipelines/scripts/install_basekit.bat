
set BASEKIT_URL="%1"
set BASEKIT_COMPONENTS="%2"

curl.exe --output installer.exe --url %BASEKIT_URL% --retry 5 --retry-delay 5
installer.exe -s -x -f webimage_extracted --log extract.log
webimage_extracted\bootstrapper.exe -s --action install --components=%BASEKIT_COMPONENTS% --eula=accept -p=NEED_VS2017_INTEGRATION=0 -p=NEED_VS2019_INTEGRATION=0 --log-dir=.      