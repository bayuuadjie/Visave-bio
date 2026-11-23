@echo off
cd /d "%~dp0"
if not exist libs mkdir libs
call :get pdf.min.js https://cdnjs.cloudflare.com/ajax/libs/pdf.js/3.11.174/pdf.min.js
call :get pdf.worker.min.js https://cdnjs.cloudflare.com/ajax/libs/pdf.js/3.11.174/pdf.worker.min.js
call :get jszip.min.js https://cdnjs.cloudflare.com/ajax/libs/jszip/3.10.1/jszip.min.js
where py >nul 2>nul
if %errorlevel%==0 ( py serve.py & goto done )
where python >nul 2>nul
if %errorlevel%==0 ( python serve.py & goto done )
where node >nul 2>nul
if %errorlevel%==0 ( node server.js & goto done )
echo Python atau Node.js belum terpasang. Install salah satunya dulu (python.org atau nodejs.org).
:done
pause
goto :eof
:get
if not exist "libs\%1" powershell -NoProfile -Command "try{Invoke-WebRequest '%2' -OutFile 'libs\%1'}catch{}"
exit /b
