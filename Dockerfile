ARG BASE_OS_VERSION='alpine'
ARG PHP_VERSION='8.4'
ARG PHP_VARIATION='fpm'

FROM php:${PHP_VERSION}-${PHP_VARIATION}-${BASE_OS_VERSION}
RUN apk add --no-cache tzdata fcgi
COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/
RUN install-php-extensions pdo_pgsql pgsql redis opcache
RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"
COPY --from=composer:2 /usr/bin/composer /usr/local/bin/