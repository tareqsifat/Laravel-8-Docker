FROM php:7.4-apache

# Set working directory
WORKDIR /var/www/html

# Install dependencies
RUN apt-get update && apt-get install -y \
    libzip-dev \
    unzip \
    && docker-php-ext-install zip pdo_mysql \
    && a2enmod rewrite

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Copy application files
COPY . /var/www/html

# Set permissions
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html/storage

# Install Laravel dependencies
RUN composer install

# Save Servername to apache2.conf
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Generate application key
RUN php artisan key:generate

# Expose port
EXPOSE 8000

# Start Apache
CMD ["apache2-foreground"]













































