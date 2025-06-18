FROM php:8.2-apache

# Install dependencies
RUN apt-get update && apt-get install -y \
    libzip-dev unzip \
    && docker-php-ext-install pdo pdo_mysql zip

# Enable Apache rewrite module
RUN a2enmod rewrite

# Set working directory
WORKDIR /var/www/html

# Copy app source
COPY . .

# Set permissions
RUN chmod -R 755 /var/www/html/storage

# Expose port 80
EXPOSE 80
