@echo off
cls

echo ***Skrypt nieobowiazkowy - Grzegorz Wanat, K63.1***
 
set sciezka=
set /p sciezka=Podaj sciezke, ktora chcesz przeszukac: 
if not exist "%sciezka%" goto BlednaSciezka
set rozszerzenie=
set /p rozszerzenie=Podaj szukane rozszerzenie w formacie np. .jpg (a nie *.jpg):
if "%rozszerzenie%" == "" goto BledneRozszerzenie

echo W podanej lokalizacji znajduja sie nastepujace pliki o podanym rozszerzeniu:
dir /s /b "%sciezka%"\"*%rozszerzenie%"
echo ------------------------------
cd %sciezka%
if exist %sciezka%.\BACKUP goto Pomin
mkdir .\BACKUP
:Pomin 
set data=%date%
if exist "%sciezka%.\BACKUP\%date%" goto Pomin2
cd "%sciezka%.\BACKUP"
mkdir "%date%"
:Pomin2
SETLOCAL ENABLEDELAYEDEXPANSION
for /f %%i in ('dir /s /b %sciezka%\*%rozszerzenie%') do (
set lokalizacja=%%i
set nazwa=%%~ni
set pierwsza=!nazwa:~0,1%!
cd %sciezka%.\BACKUP\%data%\
mkdir !pierwsza!
cd %sciezka%
set kopia=%sciezka%.\BACKUP\%data%\!pierwsza!
copy /v !lokalizacja! !kopia!
)
tree /F

goto Koniec

:BlednaSciezka
echo Wprowadzona sciezka nie istnieje!
goto Koniec

:BledneRozszerzenie
echo Nie wprowadzono rozszerzenia!
goto Koniec

:Koniec
echo Koniec skryptu