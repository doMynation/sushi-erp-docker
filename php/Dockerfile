FROM php:7.3.5-fpm-stretch
RUN apt-get update && apt-get install -y --no-install-recommends \
  # intl deps
  zlib1g-dev libicu-dev g++ \
  # imagick deps
  ghostscript \
  libmagickwand-dev \
  # gd deps
  libfreetype6-dev \
  libjpeg62-turbo-dev \
  libpng-dev \
  # xsl deps
  libxslt-dev \
  # Zip deps
  libzip-dev \
  && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
  && docker-php-ext-install -j$(nproc) gd \
  && docker-php-ext-install -j$(nproc) gettext \
  && docker-php-ext-install -j$(nproc) intl \
  && docker-php-ext-install -j$(nproc) exif \
  && docker-php-ext-install -j$(nproc) mysqli \
  && docker-php-ext-install -j$(nproc) pdo_mysql \
  && docker-php-ext-install -j$(nproc) calendar \
  && docker-php-ext-install -j$(nproc) sockets \
  && docker-php-ext-install -j$(nproc) xsl \
  && docker-php-ext-install -j$(nproc) zip \
  && docker-php-ext-install -j$(nproc) pcntl \
  && docker-php-ext-install -j$(nproc) wddx \
  && docker-php-ext-install -j$(nproc) shmop \
  && docker-php-ext-install -j$(nproc) sysvmsg \
  && docker-php-ext-install -j$(nproc) sysvsem \
  && docker-php-ext-install -j$(nproc) sysvshm \
  && docker-php-ext-install -j$(nproc) opcache \
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