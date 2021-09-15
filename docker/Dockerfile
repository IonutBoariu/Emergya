FROM drupal:8-apache

WORKDIR /var/www/html

RUN usermod -u 1000 www-data

RUN apt-get update && apt-get install -y --no-install-recommends \
  ssl-cert \
	curl \
	git \
	mariadb-client \
	vim \
	zip \
	unzip \
	wget \
  netcat

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
	php composer-setup.php && \
	mv composer.phar /usr/local/bin/composer && \
	php -r "unlink('composer-setup.php');" && \
	wget -O drush.phar https://github.com/drush-ops/drush-launcher/releases/download/0.4.2/drush.phar && \
	chmod +x drush.phar && \
	mv drush.phar /usr/local/bin/drush && \
	rm -rf /var/www/html/* && \
  rm -r /var/lib/apt/lists/* && \
  a2enmod ssl && \
  a2ensite default-ssl && \
  sed -i "s/^[ \t]*DocumentRoot \/var\/www\/html$/DocumentRoot \/var\/www\/html/" /etc/apache2/sites-enabled/default-ssl.conf

RUN composer require drush/drush

COPY apache-drupal.conf /etc/apache2/sites-enabled/000-default.conf

# Install Xdebug
RUN pecl install xdebug-2.8.1 \
    && docker-php-ext-enable xdebug

RUN cp /usr/local/etc/php/php.ini-development /usr/local/etc/php/php.ini \
 && echo "[xdebug]" >> /usr/local/etc/php/php.ini \
 && echo "xdebug.var_display_max_data = 20000" >> /usr/local/etc/php/php.ini \
 && echo "xdebug.var_display_max_depth = 10" >> /usr/local/etc/php/php.ini \
 && echo "xdebug.default_enable = 0" >> /usr/local/etc/php/php.ini \
 && echo "xdebug.idekey = \"PHPSTORM\"" >> /usr/local/etc/php/php.ini \
 && echo "xdebug.remote_enable = 1" >> /usr/local/etc/php/php.ini \
 && echo "xdebug.remote_port = 9001" >> /usr/local/etc/php/php.ini \
 && echo "xdebug.remote_autostart = 1" >> /usr/local/etc/php/php.ini \
 && echo "xdebug.remote_host = 172.17.0.1" >> /usr/local/etc/php/php.ini

