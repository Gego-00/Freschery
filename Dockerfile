FROM webdevops/php-nginx:8.3-alpine

# Set the document root for Laravel's public folder
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

# Make our custom deployment script executable
RUN chmod +x /app/render-deploy.sh

# Let the official entrypoint execute our script directly
ENTRYPOINT ["/opt/docker/bin/entrypoint.sh"]
CMD ["/app/render-deploy.sh"]
