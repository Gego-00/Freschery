FROM php:8.3-fpm

# Install standard system requirements, curl, and Nginx
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    nginx \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Download the extension installer directly using curl
RUN curl -sSL https://github.com -o /usr/local/bin/install-php-extensions && \
    chmod +x /usr/local/bin/install-php-extensions && \
    install-php-extensions gd pdo_mysql pdo_pgsql zip pcntl opcache

# Install Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /app

# Copy application files
COPY . /app

# Install PHP dependencies
RUN composer install --no-dev --optimize-autoloader --no-interaction

# Set correct permissions for Laravel directories
RUN chown -R www-data:www-data /app/storage /app/bootstrap/cache

# Copy custom Nginx configuration
COPY nginx.conf /etc/nginx/sites-available/default

# Expose Render's default port variable
ENV PORT=10000
EXPOSE 10000

# Run migrations, optimize caches, and start both PHP-FPM & Nginx
CMD php artisan migrate --force && \
    php artisan config:cache && \
    php artisan route:cache && \
    php artisan view:cache && \
    php-fpm -D && \
    nginx -g "daemon off;"
