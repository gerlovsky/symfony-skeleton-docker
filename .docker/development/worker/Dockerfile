ARG PHP_VERSION=8.0

FROM php:${PHP_VERSION}-cli-alpine

RUN apk add --no-cache unzip bash coreutils \
    && docker-php-ext-install pdo_mysql opcache

# Install SUPERVISOR
RUN apk add --no-cache supervisor

RUN ln -s $PHP_INI_DIR/php.ini-development $PHP_INI_DIR/php.ini

COPY ./.docker/common/worker/supervisord.conf /etc/supervisor/supervisord.conf
COPY ./.docker/common/worker/conf.d /etc/supervisor/conf.d

COPY ./.docker/common/php/conf.d /usr/local/etc/php/conf.d
COPY ./.docker/development/php/conf.d /usr/local/etc/php/conf.d

WORKDIR /app

