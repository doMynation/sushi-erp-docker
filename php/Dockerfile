FROM php:7.4-fpm-buster
RUN apt-get update && apt-get install -y --no-install-recommends \
  # intl deps
  zlib1g-dev libicu-dev g++ \
  # imagick deps
  ghostscript \
  libmagickwand-dev \
  # gd deps
  libfreetype6-dev \
  libjpeg-dev \
  libpng-dev \
  # Zip deps
  libzip-dev \
  && docker-php-ext-configure gd \
              --with-freetype \
              --with-jpeg \
              --enable-gd \
  && docker-php-ext-install -j$(nproc) gd \
  && docker-php-ext-install -j$(nproc) opcache \
  && docker-php-ext-install -j$(nproc) bcmath \
  && docker-php-ext-install -j$(nproc) gettext \
  && docker-php-ext-install -j$(nproc) intl \
  && docker-php-ext-install -j$(nproc) exif \
  && docker-php-ext-install -j$(nproc) mysqli \
  && docker-php-ext-install -j$(nproc) pdo_mysql \
  && docker-php-ext-install -j$(nproc) sockets \
  && docker-php-ext-install -j$(nproc) zip \
  # PECL extensions
  && pecl install imagick-3.4.3 && docker-php-ext-enable imagick \
  && pecl install apcu-5.1.17 && docker-php-ext-enable apcu \
  # Clean up
  && rm -rf /var/lib/apt/lists/*

# Dev utils (comment this line in prod)
RUN apt-get update && apt-get install -y --no-install-recommends \
  vim \
  && rm -rf /var/lib/apt/lists/*

RUN mv $PHP_INI_DIR/php.ini-production $PHP_INI_DIR/php.ini
RUN usermod -u 1000 www-data
RUN usermod -G staff www-data
EXPOSE 9000