FROM dunglas/frankenphp:1.1-php8.3

# Install necessary system dependencies and PHP extensions for Laravel
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libzip-dev \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd pdo_mysql zip pcntl opcache

# Install Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /app

# Copy application files
COPY . /app

# Install PHP dependencies
RUN composer install --no-dev --optimize-autoloader --no-interaction

# Set correct permissions for Laravel
RUN chown -R www-data:www-data /app/storage /app/bootstrap/cache

# Expose Render's default port variable
ENV PORT=10000
EXPOSE 10000

# Run FrankenPHP targeting Laravel's public directory
CMD ["frankenphp", "php-server", "--listen", ":10000", "--root", "public/"]
