FROM php:8.3-fpm

ENV COMPOSER_ALLOW_SUPERUSER=1

WORKDIR /var/www/html
RUN apt-get update -y && apt-get install -y openssl zip unzip git
RUN docker-php-ext-install mysqli pdo pdo_mysql

# install composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

COPY composer.* /var/www/html/
RUN composer install --no-interaction --no-dev --no-scripts

COPY . /var/www/html

EXPOSE 80

# generate a custom APP_KEY within your environment variables
ENV APP_KEY=${APP_KEY:-"base64:iwGHg6152clSDBYopOY0WR7NjX7sItBuRNArsnLPlTk="}

CMD ["php", "artisan", "serve", "--host", "0.0.0.0", "--port", "80"]
