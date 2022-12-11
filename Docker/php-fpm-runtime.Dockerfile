FROM php:8.1-fpm-alpine

WORKDIR /var/www/
RUN rm -rf /var/www/* && chown www-data:www-data -R /var/www

# Install Deps
RUN apk add --no-cache git sed nodejs npm openssh-client libzip-dev libsodium-dev icu-dev mysql-client supervisor freetype-dev libjpeg-turbo-dev libpng-dev
RUN apk add --no-cache $PHPIZE_DEPS

# install modules
RUN docker-php-ext-configure gd --with-freetype=/usr/include/ --with-jpeg=/usr/include/
RUN docker-php-ext-install gd
RUN docker-php-ext-install zip
RUN docker-php-ext-install sodium
RUN docker-php-ext-install pdo_mysql
RUN docker-php-ext-install intl
RUN docker-php-ext-install bcmath
RUN docker-php-ext-install sockets
RUN docker-php-ext-install pcntl

ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/
RUN chmod +x /usr/local/bin/install-php-extensions

RUN install-php-extensions imagick
RUN install-php-extensions redis
RUN install-php-extensions @composer
RUN install-php-extensions opcache

RUN touch /usr/local/etc/php-fpm.d/zz-docker.conf \
    && echo '[global]' >> /usr/local/etc/php-fpm.d/zz-docker.conf \
    && echo 'daemonize = no' >> /usr/local/etc/php-fpm.d/zz-docker.conf \
    && echo '[www]' >> /usr/local/etc/php-fpm.d/zz-docker.conf \
    && echo 'listen = 9000' >> /usr/local/etc/php-fpm.d/zz-docker.conf \
    && echo 'pm = static' >> /usr/local/etc/php-fpm.d/zz-docker.conf \
    && echo 'pm.max_children = 1' >> /usr/local/etc/php-fpm.d/zz-docker.conf

# Configure PHP.ini
RUN mv "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"
RUN sed -i 's/memory_limit = 128M/memory_limit = -1/g' $PHP_INI_DIR/php.ini
RUN sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 100M/g' $PHP_INI_DIR/php.ini
RUN sed -i 's/post_max_size = 8M/post_max_size = 100M/g' $PHP_INI_DIR/php.ini
RUN sed -i 's/max_execution_time = 30/max_execution_time = 300/g' $PHP_INI_DIR/php.ini

#Configure Entry
RUN touch /usr/bin/entry \
&& touch /usr/bin/start \
&& touch /usr/bin/first \

&& echo '#!/bin/sh' >> /usr/bin/entry \
&& echo 'umask 0002' >> /usr/bin/entry \
&& echo '/usr/bin/start' >> /usr/bin/entry \

&& echo '#!/bin/sh' >> /usr/bin/start \
&& echo 'supervisord -c /etc/supervisord.conf' >> /usr/bin/start \
&& echo 'supervisorctl reload' >> /usr/bin/start \
&& echo "php-fpm" >> /usr/bin/start \

&& echo '#!/bin/sh' >> /usr/bin/first \
&& echo 'cd /var/www/' >> /usr/bin/first \
&& echo 'php artisan storage:link' >> /usr/bin/first \
&& echo 'php artisan key:generate' >> /usr/bin/first \
&& echo 'php artisan migrate:fresh --seed' >> /usr/bin/first \

&& chmod +x,o+x,g+x /usr/bin/start \
&& chmod +x,o+x,g+x /usr/bin/entry \
&& chmod +x,o+x,g+x /usr/bin/first

STOPSIGNAL SIGTERM
EXPOSE 9000
ENTRYPOINT  ["/usr/bin/entry"]
CMD  ["/usr/bin/entry"]
