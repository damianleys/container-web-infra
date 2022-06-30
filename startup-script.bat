@echo off

if "%~1" == "" (
    echo "ERROR: No parameter passed"
    echo "===================================================="
    goto help
)

if Not "%~1" == "dev" if Not "%~1" == "prod" (
    echo "ERROR: Parameter passed is not a valid parameter"
    goto help
)

echo "Checking file %CD%\.env.%~1"
if Not exist "%CD%\.env.%~1" (
    echo "WARNING: environment file not found"
    echo "NOTICE: will try configuration variables from environment"
) else (
    echo "Configured for %~1 environment"
    set CONFIG_FILE=--env-file .env.%~1
)

if Not exist "%CD%/docker-compose-mysql.yml" (
    echo "ERROR: docker-compose file not found"
    echo "===================================================="
    goto help
)
copy "%CD%\docker-compose-mysql.yml" "%CD%\docker-compose.yml" 

goto main

:help
echo "===================================================="
echo "This script will start docker-compose for you."
echo "It will set the current directory as working directory."
echo "Only provide the environment you want to build,"
echo "using dev or prod as parameters. "
echo "E.G.: ./startup-script.bat dev"
echo "===================================================="
goto end

:main
echo "Exporting working directory"
set WORK_DIR=%CD%

echo "Starting docker-compose"
echo "Building up %~1 environment"
set COMMAND="docker-compose %CONFIG_FILE% up build --remove-orphans"
echo %COMMAND%
docker-compose %CONFIG_FILE% up --build --remove-orphans

:end
