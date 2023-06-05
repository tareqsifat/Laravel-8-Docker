# FROM php:7.4-apache

# # Set working directory
# WORKDIR /var/www/html

# # Install dependencies
# RUN apt-get update && apt-get install -y \
#     libzip-dev \
#     unzip \
#     && docker-php-ext-install zip pdo_mysql \
#     && a2enmod rewrite

# # Copy application files
# COPY . /var/www/html

# # Change working directory
# RUN cd /var/www/html

# # Install Composer
# RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer


# # Set permissions
# RUN chown -R www-data:www-data /var/www/html \
#     && chmod -R 755 /var/www/html/storage

# # Install Laravel dependencies
# # RUN composer install --no-interaction --no-plugins --no-scripts --ignore-platform-reqs
# RUN composer install

# # Save Servername to apache2.conf
# RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# # Generate application key
# RUN php artisan key:generate
# RUN php artisan -V
# # Expose port
# # EXPOSE 8000

# # # Start Apache
# # CMD ["apache2-foreground"]

# Base image
FROM php:7.4-cli

# Set working directory
WORKDIR /var/www/html

# Install PHP extensions required by Laravel
RUN apt-get update && apt-get install -y \
    libzip-dev \
    zip \
    unzip

RUN docker-php-ext-install pdo_mysql bcmath zip

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer



# Copy Laravel files
COPY . .

# Install project dependencies
RUN composer install --no-interaction

# Set proper ownership and permissions for Laravel files
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html/storage \
    && chmod +x /var/www/html/vendor/autoload.php
    
# Expose port 8000
EXPOSE 8000

# Set entry point
CMD php artisan serve --host=0.0.0.0 --port=8000












































