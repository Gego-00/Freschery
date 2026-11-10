#!/bin/sh

# Run Laravel optimizations
php artisan migrate --force
php artisan config:cache
php artisan route:cache
php artisan view:cache

# Wait a brief moment for PHP-FPM initialization
sleep 3

# Hand off execution to the standard webdevops webserver supervisor
exec supervisord
