FROM php:8.4-cli-alpine

RUN apk add --no-cache tzdata bash nodejs npm 
RUN apk add --no-cache \
      libzip-dev \
      zip icu-dev\
    && docker-php-ext-install zip
RUN docker-php-ext-configure intl && docker-php-ext-install intl

RUN ( curl -sSLf https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions -o - || echo 'return 1' ) | sh -s \
      gd xdebug

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN npm install --global yarn

ENV TZ=Europe/Brussels
ENV COMPOSER_ALLOW_SUPERUSER=1

CMD ["/bin/bash"]