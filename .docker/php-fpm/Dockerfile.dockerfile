# Build: docker build -t php-fpm -f .docker/php-fpm/Dockerfile.dockerfile .
FROM php:8.2-fpm

# Install dependencies
RUN apt-get update && apt-get install -y \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    git \
    curl \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    bash

# install redis
RUN pecl install redis && docker-php-ext-enable redis

# install other services
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# install composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Install Node.js and npm
RUN apt-get update && apt-get install -y nodejs npm

# set working directory
WORKDIR /var/www

# copy source code
COPY . /var/www

# Expose port 9000 and start php-fpm server
EXPOSE 9000
CMD ["php-fpm"]