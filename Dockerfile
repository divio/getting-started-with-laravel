FROM php:8.3-apache

ENV COMPOSER_ALLOW_SUPERUSER=1

WORKDIR /var/www/html

RUN apt-get update -y && apt-get install -y openssl zip unzip git
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

COPY . /var/www/html
RUN composer install --prefer-dist

EXPOSE 80

CMD ["php", "artisan", "serve", "--host", "0.0.0.0", "--port", "80"]
