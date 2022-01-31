ARG PHP_VERSION=8.1

FROM php:${PHP_VERSION}-fpm-alpine

RUN apk add --no-cache unzip bash coreutils git \
    && docker-php-ext-install pdo_mysql opcache

COPY --from=composer /usr/bin/composer /usr/bin/composer

COPY .docker/common/php/docker-healthcheck.sh /usr/local/bin/docker-healthcheck
RUN chmod +x /usr/local/bin/docker-healthcheck

HEALTHCHECK --interval=10s --timeout=3s --retries=3 CMD ["docker-healthcheck"]

RUN ln -s $PHP_INI_DIR/php.ini-production $PHP_INI_DIR/php.ini

COPY .docker/common/php/conf.d /usr/local/etc/php/conf.d
COPY .docker/production/php/conf.d /usr/local/etc/php/conf.d
COPY .docker/common/php/php-fpm.d/zz-docker.conf /usr/local/etc/php-fpm.d/zz-docker.conf

WORKDIR /app

# copy only specifically what we need
COPY composer.json composer.lock ./
COPY .env ./

COPY bin bin/
COPY config config/
COPY migrations migrations/
COPY public public/
COPY src src/
COPY spec spec/
COPY migrations migrations/

RUN set -eux; \
	mkdir -p var/cache var/log; \
	composer install --prefer-dist --no-dev --no-progress --no-scripts --no-interaction; \
	composer dump-autoload --classmap-authoritative --no-dev; \
	composer symfony:dump-env prod; \
	composer run-script --no-dev post-install-cmd; \
	chmod +x bin/console; sync

# do not use .env files in production
RUN composer dump-env prod;
