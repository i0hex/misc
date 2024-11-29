@echo off

:: Get the basename of the script file(e.g., project_gen.bat)
set scriptName=%~nx0

:: Get the first parameter as an option
set option=%1

if "%option%"=="" (
	echo Not enough parameter. At least one parameter.
	call :echoHelp
	exit /b 1
)

:: Function to be executed, defaults to 'echoHelp'
set func=echoHelp

if "%option%"=="-help" (
	call :echoHelp 
	exit /b 0
)else if "%option%"=="-common" (
	set func=genCommon
)else if "%option%"=="-res" (
	set func=genResource
)else if "%option%"=="-doc" (
	set func=genDocument
)else if "%option%"=="-test" (
	set func=genTest
)else if "%option%"=="-cmake" (
	set func=genCmake
)else if "%option%"=="-advanced" (
	set func=genAdvanced
)else if "%option%"=="-all" (
	set func=genAll
)else (
	echo %scriptName%: Invalid option -- '%1' 
	call :echoHelp
	exit /b 1
)

:: Get the second parameter as a directory
set directory=%2

if "%directory%"=="" (
	:: Create struture in the current directory
	call :%func%
) else if "%directory%"=="." (
	:: Create struture in the current directory
	call :%func%
) else (
	:: Check if the directory exists
	if exist "%directory%" (
		echo Directory exists.
		exit /b 1
	)

	:: Add a trailing backslash if there is no backslash at the end of the directory parameter
	set lastChar=%directory:~-1%
	if not "%lastChar%"=="\" set directory=%directory%\

	:: Check if the directory successfully created
	mkdir %directory%
	if not exist "%directory%" (
		echo Failed to create the directory.
		exit /b 1
	)

	:: Switch to the specified directory and create specified directories
	cd %directory%
	call :%func%
	cd ..
)

echo Project directories created.
:: Exit script. Avoid calling the following functions
exit /b 0

:echoHelp
echo.
echo Create directory structure of the C/C++ project.
echo.
echo Usage: %scriptName% ^<option^> ^<directory^>
echo Options:
echo     -common    - Create common project directories ^(include, src, lib, build^)
echo     -res       - Create resource directories ^(assets, config^)
echo     -doc       - Create documentation ^(doc, README.md^)
echo     -test      - Create test directories
echo     -cmake     - Create a CMakeLists.txt
echo     -advanced  - Create common and resource directories
echo     -all       - Create common, resource, document and test directories
goto :eof

:genCommon
mkdir include
mkdir src
mkdir lib
mkdir build
goto :eof

:genResource
mkdir assets
mkdir config
goto :eof

:genTest
mkdir tests
goto :eof

:genDocument
mkdir doc
echo. > README.md
goto :eof

:genCmake
call :genCommon
echo. > CMakeLists.txt
goto :eof

:genAdvanced
call :genCommon
call :genResource
goto :eof

:genAll
call :genCommon
call :genResource
call :genDocument
call :genTest
goto :eof