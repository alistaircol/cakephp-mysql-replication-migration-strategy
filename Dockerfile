FROM php:7.4-apache
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y \
        apt-utils \
        pv \
        jq \
        zip \
        git \
        curl \
        nano \
        unzip \
        zlibc \
        zlib1g \
        libzip-dev \
    && docker-php-ext-install \
        zip \
        pdo \
        pdo_mysql \
    && a2enmod rewrite \
    && usermod -u 1000 www-data

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html
