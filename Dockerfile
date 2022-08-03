FROM php:8.1-fpm

WORKDIR /var/www

RUN apt-get update \
    && apt-get install -y \
        build-essential \
        default-mysql-client \
        libzip-dev \
        libpng-dev \
        libjpeg62-turbo-dev \
        libfreetype6-dev \
        libonig-dev \
        locales \
        zip \
        jpegoptim optipng pngquant gifsicle \
        nano \
        unzip \
        git \
        curl \
        cron \
        iputils-ping \
    && curl -fsSL https://deb.nodesource.com/setup_14.x | bash - \
    && apt-get update \
    && apt-get install -y nodejs \
    && apt-get -y autoremove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN docker-php-ext-install pdo_mysql mbstring zip exif pcntl \
    && docker-php-ext-configure gd --enable-gd --with-freetype=/usr/include/ --with-jpeg=/usr/include/ \
    && docker-php-ext-install gd

RUN sed -i -e 's/# id_ID.UTF-8 UTF-8/id_ID.UTF-8 UTF-8/' /etc/locale.gen \
    && echo "Asia/Jakarta" > /etc/timezone \
    && dpkg-reconfigure --frontend=noninteractive locales

RUN curl --silent --show-error https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && composer global require "laravel/envoy"
