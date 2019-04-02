FROM php:7.2-fpm

# Set Working directory
WORKDIR /var/www

# Variables Environment
ENV ACCEPT_EULA=Y

# Install Dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    mysql-client \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    locales \
    zip \
    jpegoptim optipng pngquant gifsicle \
    nano \
    unzip \
    git \
    curl \
    cron \
    iputils-ping \
    gnupg gnupg1 gnupg2

RUN apt-get update \
    && curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
    && curl https://packages.microsoft.com/config/debian/9/prod.list \
        > /etc/apt/sources.list.d/mssql-release.list \
    && apt-get install -y --no-install-recommends \
        locales \
        apt-transport-https \
    && echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
    && locale-gen \
    && apt-get update \
    && apt-get -y --no-install-recommends install \
        unixodbc-dev \
        msodbcsql17

# Clear Cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Setup Timezone
RUN echo "Asia/Jakarta" > /etc/timezone && rm -f /etc/localtime && dpkg-reconfigure -f noninteractive tzdata

# Install Extensions
RUN docker-php-ext-install pdo_mysql mbstring zip exif pcntl && pecl install sqlsrv pdo_sqlsrv xdebug
RUN docker-php-ext-configure gd --with-gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ --with-png-dir=/usr/include/
RUN docker-php-ext-install gd
RUN docker-php-ext-enable sqlsrv pdo_sqlsrv xdebug

# Install Composer
RUN curl --silent --show-error https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install Laravel Envoy
RUN composer global require "laravel/envoy"
