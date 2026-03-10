#!/bin/bash
set -e

echo "[entrypoint] Waiting for MySQL..."
git config --global --add safe.directory /var/www || true

for i in $(seq 1 60); do
  if php -r "
    try {
      new PDO(
        'mysql:host=' . getenv('DB_HOST') . ';port=' . getenv('DB_PORT') . ';dbname=' . getenv('DB_DATABASE'),
        getenv('DB_USERNAME'),
        getenv('DB_PASSWORD'),
        [PDO::ATTR_TIMEOUT => 2]
      );
      exit(0);
    } catch (Throwable \$e) {
      exit(1);
    }
  " 2>/dev/null; then
    echo "[entrypoint] MySQL is ready."
    break
  fi
  if [ "$i" -eq 60 ]; then
    echo "[entrypoint] MySQL did not become ready in time."
    exit 1
  fi
  echo "[entrypoint] Attempt $i/60..."
  sleep 2
done

# Generate APP_KEY if not set
if ! grep -q '^APP_KEY=base64:' .env 2>/dev/null; then
  php artisan key:generate --no-interaction --force 2>/dev/null || true
fi

echo "[entrypoint] Installing PHP dependencies..."
composer install --no-interaction --prefer-dist --optimize-autoloader

echo "[entrypoint] Installing Node dependencies and building assets..."
npm install
npm run build

php artisan storage:link 2>/dev/null || true
chown -R www-data:www-data storage bootstrap/cache 2>/dev/null || true
chmod -R 775 storage bootstrap/cache 2>/dev/null || true

echo "[entrypoint] Running migrations..."
php artisan migrate --force || echo "[entrypoint] Migration failed or already up to date."

echo "[entrypoint] Starting PHP-FPM..."
exec php-fpm
