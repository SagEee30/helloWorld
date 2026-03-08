#!/bin/bash
set -e

# Install PHP dependencies
composer install --no-interaction --prefer-dist --optimize-autoloader

# Install Node dependencies and build assets
npm install
npm run build

# Create storage link
php artisan storage:link 2>/dev/null || true

# Set proper permissions
chown -R www-data:www-data storage bootstrap/cache
chmod -R 775 storage bootstrap/cache

# Run database migrations
php artisan migrate --force

exec php-fpm
