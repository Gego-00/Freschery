FROM webdevops/php-nginx:8.3-alpine

# Set the document root for Laravel's public folder (Configures Nginx automatically)
ENV WEB_DOCUMENT_ROOT=/app/public
ENV PORT=10000
EXPOSE 10000

# Set working directory
WORKDIR /app

# Copy the entire project
COPY . /app

# Install Composer dependencies
RUN composer install --no-dev --optimize-autoloader --no-interaction

# Set perfect permissions for Laravel
RUN chown -R application:application /app/storage /app/bootstrap/cache

# Overwrite the container startup using the exact path for webdevops entrypoint engine
CMD php artisan migrate --force && \
    php artisan config:cache && \
    php artisan route:cache && \
    php artisan view:cache && \
    /opt/docker/bin/entrypoint.sh
