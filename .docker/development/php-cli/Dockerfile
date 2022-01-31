ARG PHP_VERSION=8.0

FROM php:${PHP_VERSION}-cli-alpine

RUN apk add --no-cache unzip bash coreutils git \
    && docker-php-ext-install pdo_mysql opcache

ARG XDEBUG_ENABLE=false
ENV XDEBUG_ENABLE=${XDEBUG_ENABLE:-false}

ARG XDEBUG_VERSION
ENV XDEBUG_VERSION=${XDEBUG_VERSION:-3.1.2}

RUN if [ $XDEBUG_ENABLE = "true" ]; then \
    git clone --branch $XDEBUG_VERSION --depth 1 https://github.com/xdebug/xdebug.git /usr/src/php/ext/xdebug \
    && docker-php-ext-configure xdebug --enable-xdebug-dev \
    && docker-php-ext-install xdebug \
    ; fi;

RUN ln -s $PHP_INI_DIR/php.ini-development $PHP_INI_DIR/php.ini

COPY --from=composer /usr/bin/composer /usr/bin/composer

COPY ./.docker/common/php/conf.d /usr/local/etc/php/conf.d
COPY ./.docker/development/php/conf.d /usr/local/etc/php/conf.d

COPY ./.docker/common/wait-for-it.sh /usr/local/bin/wait-for-it
RUN chmod 555 /usr/local/bin/wait-for-it

WORKDIR /app
