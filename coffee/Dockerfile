FROM composer AS compose-build
WORKDIR /app

COPY . .
RUN composer update && composer install

FROM node:20-alpine AS node-builder
WORKDIR /app

COPY --from=compose-build /app /app
RUN npm install

FROM php:8.4-cli-alpine AS runtime 

RUN apk add --no-cache \
    mysql-client \
    mariadb-connector-c \
    mariadb-dev \
    $PHPIZE_DEPS \
 && docker-php-ext-install pdo pdo_mysql \
 && apk del $PHPIZE_DEPS

WORKDIR /app

COPY --from=node-builder /app /app
RUN cp .env.example .env

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8002"]
