FROM php:7.0.33-fpm

RUN apt-get update && apt-get install -y autoconf pkg-config libssl-dev \
    && pecl install xdebug-2.9.0 mongodb-1.8.2

RUN docker-php-ext-install pdo pdo_mysql mysqli \
    && docker-php-ext-enable pdo_mysql pdo xdebug mongodb

RUN mkdir -p /home/xdebug
COPY ./xdebug-debug.ini /home/xdebug/xdebug-debug.ini
COPY ./xdebug-default.ini /home/xdebug/xdebug-default.ini
COPY ./xdebug-off.ini /home/xdebug/xdebug-off.ini
COPY ./xdebug-profile.ini /home/xdebug/xdebug-profile.ini
COPY ./xdebug-trace.ini /home/xdebug/xdebug-trace.ini

ARG XDEBUG_MODES
ARG REMOTE_HOST="host.docker.internal"
ARG REMOTE_PORT=9003
ARG IDE_KEY="docker"
ARG ENVIRONMENT="development"

ENV MODES=$XDEBUG_MODES
ENV CLIENT_HOST=$REMOTE_HOST
ENV CLIENT_PORT=$REMOTE_PORT
ENV IDEKEY=$IDE_KEY
ENV ENVIRONMENT=$ENVIRONMENT

RUN mv "$PHP_INI_DIR/php.ini-${ENVIRONMENT}" "$PHP_INI_DIR/php.ini" \
    && pecl config-set php_ini "$PHP_INI_DIR/php.ini" \
    && echo "extension=mongodb.so" >> "$PHP_INI_DIR/conf.d/mongodb.ini"

COPY ./entrypoint.sh /home/entrypoint

RUN chmod +x /home/entrypoint

ENTRYPOINT ["/home/entrypoint"]
