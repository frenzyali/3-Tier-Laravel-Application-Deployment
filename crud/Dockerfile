FROM davidzapata/php-composer-alpine 
WORKDIR /app

COPY . .
RUN composer update && composer install
RUN cp .env.example .env
RUN php artisan key:generate --ansi 

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8001"]
