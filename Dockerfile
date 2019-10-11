FROM php:7.3-apache

# apache2 setup
COPY ./assets/shopware.conf /etc/apache2/sites-available/000-default.conf

RUN apt-get update -qq && \
    apt-get upgrade -qq && \
    apt-get install -qq apt-utils wget

RUN apt-get update -qq && \
    apt-get install -qq \
    libssh2-1-dev \
    libssh2-1 \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libxml2-dev \
    libicu-dev \
    libmcrypt-dev \
    libpng-dev \
    libcurl4-openssl-dev \
    libcurl3 \
    libxslt1-dev \
    zlib1g-dev \
    curl \
    zip \
    unzip

# install php extensions
RUN docker-php-ext-install \
    gd \
    zip \
    unzip \
    curl \
    intl \
    pdo \
    pdo_mysql \
    soap

RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
    pecl install ssh2-1.1.2

RUN a2enmod rewrite
