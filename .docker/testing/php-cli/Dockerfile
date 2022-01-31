FROM php:8.0-cli-alpine

RUN apk add --no-cache unzip bash coreutils \
    && docker-php-ext-install pdo_mysql opcache

WORKDIR /app

RUN mv $PHP_INI_DIR/php.ini-production $PHP_INI_DIR/php.ini

COPY ./.docker/common/php/conf.d /usr/local/etc/php/conf.d
COPY ./.docker/testing/php/conf.d /usr/local/etc/php/conf.d

COPY ./.docker/common/wait-for-it.sh /usr/local/bin/wait-for-it
RUN chmod 555 /usr/local/bin/wait-for-it

ENV COMPOSER_ALLOW_SUPERUSER 1
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/bin --filename=composer --quiet

# copy only specifically what we need
COPY composer.json composer.lock ./
COPY symfony.lock ./
COPY .env ./
COPY .php-cs-fixer.php ./
COPY .phplint.yml ./
COPY Makefile ./
COPY phpstan.neon ./
COPY phpstan-baseline.neon ./
COPY phpunit.xml ./

COPY bin bin/
COPY config config/
COPY migrations migrations/
COPY public public/
COPY src src/
COPY migrations migrations/
COPY tests tests/

RUN composer install --prefer-dist --optimize-autoloader \
    && rm -rf /root/.composer/cache

RUN set -eux; \
	mkdir -p var/cache var/log var/files; \
	chmod +x bin/console; sync

# do not use .env files in production
RUN composer dump-env prod;
