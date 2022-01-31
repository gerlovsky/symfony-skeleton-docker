docker-build:
	docker-compose build

docker-config:
	docker-compose config

docker-up:
	docker-compose up -d

docker-down:
	docker-compose down --remove-orphans

docker-down-clear:
	docker-compose down -v --remove-orphans

api-composer-install:
	docker-compose run --rm api-php-cli composer install

api-composer-update:
	docker-compose run --rm api-php-cli composer update

api-wait-db:
	docker-compose run --rm api-php-cli wait-for-it api-mysql:3306 -t 30

api-migrations-create-database:
	docker-compose run --rm api-php-cli php /app/bin/console doctrine:database:create --if-not-exists

api-migrations:
	docker-compose run --rm api-php-cli php /app/bin/console doctrine:migrations:migrate

api-fixtures:
	docker-compose run --rm api-php-cli php /app/bin/console fixtures:load

api-check: api-lint api-phpstan api-test

api-validate-mapping:
	docker-compose run --rm api-php-cli php /app/bin/console doctrine:mapping:info

api-validate-schema:
	docker-compose run --rm api-php-cli php /app/bin/console doctrine:schema:validate

api-validate-migration:
	docker-compose run --rm api-php-cli php /app/bin/console doctrine:migrations:migrate --no-interaction

api-lint:
	docker-compose run --rm api-php-cli vendor/bin/phplint

api-cs-fix:
	docker-compose run --rm api-php-cli vendor/bin/php-cs-fixer fix --allow-risky=yes

api-cs-fix-dry:
	docker-compose run --rm api-php-cli vendor/bin/php-cs-fixer fix --dry-run --allow-risky=yes --diff

api-phpstan:
	docker-compose run --rm api-php-cli vendor/bin/phpstan analyse

api-phpstan-gitlab:
	docker-compose run --rm api-php-cli vendor/bin/phpstan analyse --no-progress --error-format gitlab > phpstan.json

api-test:
	docker-compose run --rm api-php-cli vendor/bin/phpunit --configuration phpunit.xml

api-test-coverage:
	docker-compose run --rm -e XDEBUG_MODE=coverage api-php-cli vendor/bin/phpunit --colors=always --coverage-html var/test/coverage

api-test-unit:
	docker-compose run --rm api-php-cli vendor/bin/phpunit --testsuite=unit

api-test-unit-coverage:
	docker-compose run --rm api-php-cli vendor/bin/phpunit XDEBUG_MODE=coverage phpunit --colors=always --coverage-html var/test/coverage --testsuite=unit

api-test-functional:
	docker-compose run --rm api-php-cli vendor/bin/phpunit --testsuite=functional

api-test-functional-coverage:
	docker-compose run --rm -e XDEBUG_MODE=coverage api-php-cli vendor/bin/phpunit --colors=always --coverage-html var/test/coverage --testsuite=functional

try-build:
	REGISTRY=localhost IMAGE_TAG=0 SERVICE_ID=symfony-skeleton-docker make build-api

build-api:
	docker --log-level=debug build --pull --file=.docker/production/nginx/Dockerfile --tag=${REGISTRY}/${SERVICE_ID}-api-nginx:${IMAGE_TAG} ./
	docker --log-level=debug build --pull --file=.docker/production/php-fpm/Dockerfile --tag=${REGISTRY}/${SERVICE_ID}-api-php-fpm:${IMAGE_TAG} ./
	docker --log-level=debug build --pull --file=.docker/production/php-cli/Dockerfile --tag=${REGISTRY}/${SERVICE_ID}-api-php-cli:${IMAGE_TAG} ./
	docker --log-level=debug build --pull --file=.docker/production/php-cli/Dockerfile --tag=${REGISTRY}/${SERVICE_ID}-api-worker:${IMAGE_TAG} ./

