FROM php:7.1-fpm-alpine

RUN apk --no-cache add openldap-dev \
		       libpng-dev \
                       libxml2-dev \
                       gettext-dev \
                       libjpeg-turbo-dev \
                       freetype-dev \
                       bzip2-dev \
                       libmcrypt-dev \
                       libxslt-dev \
                       libtool \
                       imagemagick-dev \
                       libmemcached-dev \
                       cyrus-sasl-dev \
                       ${PHPIZE_DEPS}

RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ \
                                --with-jpeg-dir=/usr/include/ && \
    docker-php-ext-install bcmath \
                           bz2 \
                           calendar \
                           dba \
                           exif \
                           gd \
                           gettext \
                           mcrypt \
                           mysqli \
                           shmop \
                           soap \
                           sockets \
                           sysvmsg \
                           sysvsem \
                           sysvshm \
                           wddx \
                           xsl \
                           opcache \
                           zip \
			   ldap \
                           pdo_mysql && \
    pecl install imagick && \
    pecl install memcached-3.0.3 && \
    pecl install timezonedb && \
    docker-php-ext-enable imagick \
                          memcached \
                          timezonedb

RUN echo "include=etc/php-fpm.custom.d/*.conf" >> /usr/local/etc/php-fpm.conf && \
    apk del ${PHPIZE_DEPS} libtool

VOLUME ["/usr/local/etc/php-fpm.custom.d"]
