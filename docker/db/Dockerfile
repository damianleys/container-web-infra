ARG DB_ENGINE
FROM ${DB_ENGINE}:latest

COPY ./init.sql /docker-entrypoint-initdb.d/init.sql
