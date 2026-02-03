#!/bin/sh

echo "Waiting for database..."

until php -r "
try {
    new PDO(
        'mysql:host=' . getenv('DB_HOST') .
        ';port=' . getenv('DB_PORT') .
        ';dbname=' . getenv('DB_DATABASE'),
        getenv('DB_USERNAME'),
        getenv('DB_PASSWORD'),
        [PDO::ATTR_TIMEOUT => 5]
    );
} catch (Throwable \$e) {
    exit(1);
}
"; do
  sleep 2
done


echo "Database is ready!"

php artisan key:generate
php artisan storage:link
FILESYSTEM_DISK=public
php artisan migrate
php artisan db:seed


exec "$@"

