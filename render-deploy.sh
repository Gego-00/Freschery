#!/bin/sh

# Run Laravel optimizations
php artisan migrate --force
php artisan config:cache
php artisan route:cache
php artisan view:cache

# Hand off execution to the standard webdevops webserver supervisor
exec supervisord
