FROM php:8.2-apache

# Install ekstensi PHP dan tools tambahan
RUN apt-get update && apt-get install -y \
    libzip-dev unzip curl git \
    && docker-php-ext-install pdo_mysql zip

# Install Composer dari official image
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copy seluruh project ke direktori kerja container
COPY . /var/www/html

# Ubah permission agar bisa diakses Apache
RUN chown -R www-data:www-data /var/www/html \
    && a2enmod rewrite

# Set direktori kerja
WORKDIR /var/www/html

# Jalankan composer install
RUN composer install --no-interaction --prefer-dist --optimize-autoloader

# Buka port 80 untuk web server
EXPOSE 80
