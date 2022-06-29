#!/bin/bash 
Help()
{
    # Display Help
    echo "===================================================="
    echo "This script will start docker-compose for you."
    echo "It will set the current directory as working directory."
    echo "Only provide the environment you want to build,"
    echo "using dev or prod as parameters. "
    echo "E.G.: ./startup-script.sh dev"
    echo "===================================================="
}

if [ $# -eq 0 ]; then 
    Help
    echo "ERROR: No parameter passed"
    exit 1
fi

if [ "$1" != "dev" ] && [ "$1" != "prod" ]; then
    Help
    echo "ERROR: Parameter passed is not a valid parameter"
    exit 1
fi

if [ ! -f "./.env.${1}" ]; then
    echo "WARNING: environment file not found"
    echo "NOTICE: will try configuration variables from environment"
else
    echo "Configured for $1 environment"
    CONFIG_FILE="--env-file=.env.${1}"
fi

# select arch and switch to mariadb if M1
if [[ $(arch) == arm* ]]; then
    echo "Setting to mariadb for ARM platform compatibility"
    export DB_ENGINE="mariadb"
else
    echo "Setting to mysql for db engine"
    export DB_ENGINE="mysql"
fi

cp docker-compose-"${DB_ENGINE}".yml docker-compose.yml

if [ ! -f "./docker-compose.yml" ] && [ ! -f "./docker-compose.yaml" ]; then
    echo "ERROR: docker-compose file not found"
    exit 1
fi

echo "Exporting working directory"
export WORK_DIR=${PWD}

echo "Starting docker-compose"
COMMAND="docker-compose ${CONFIG_FILE} up --build --remove-orphans"

echo $COMMAND
docker-compose ${CONFIG_FILE} up --build --remove-orphans