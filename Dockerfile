FROM php:8.1.3-cli-alpine3.15

RUN apk add --no-cache \
        curl \
        libcurl \
        wget \
        libzip-dev \
        libmcrypt-dev \
        libxslt-dev \
        libxml2-dev \
        icu-dev \
        zip

RUN docker-php-ext-install \
        opcache \
        zip \
        xsl \
        dom \
        exif \
        intl \
        pcntl \
        bcmath \
        sockets

ENV COMPOSER_ALLOW_SUPERUSER=1

RUN curl -s https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin/ --filename=composer

RUN rm -rf /var/lib/apt/lists/*

RUN docker-php-source delete \
        && apk del ${BUILD_DEPENDS}

LABEL org.opencontainers.image.source=https://github.com/metrixio/dockerfile-php
LABEL org.opencontainers.image.description="Docker file for colelctors"
LABEL org.opencontainers.image.licenses=MIT