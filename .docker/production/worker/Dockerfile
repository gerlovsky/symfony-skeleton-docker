FROM php:8.0-cli-alpine

RUN apk add --no-cache unzip bash coreutils \
    && docker-php-ext-install pdo_mysql opcache

# Install SUPERVISOR
RUN apk add --no-cache supervisor

RUN ln -s $PHP_INI_DIR/php.ini-production $PHP_INI_DIR/php.ini

COPY --from=composer /usr/bin/composer /usr/bin/composer

COPY ./.docker/common/worker/supervisord.conf /etc/supervisor/supervisord.conf
COPY ./.docker/common/worker/conf.d /etc/supervisor/conf.d

COPY ./.docker/common/php/conf.d /usr/local/etc/php/conf.d
COPY ./.docker/production/php/conf.d /usr/local/etc/php/conf.d

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

RUN composer install --no-dev --prefer-dist --no-progress --optimize-autoloader \
    && rm -rf /root/.composer/cache

RUN set -eux; \
	mkdir -p var/cache var/log var/files; \
	chmod +x bin/console; sync

# do not use .env files in production
RUN composer dump-env prod;
