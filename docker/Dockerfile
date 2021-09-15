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

RUN docker-php-ext-install bcmath

COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

RUN a2enmod ssl && \
    a2ensite default-ssl && \
    sed -i "s/^[ \t]*DocumentRoot \/var\/www\/html$/DocumentRoot \/var\/www\/html/" /etc/apache2/sites-enabled/default-ssl.conf

COPY apache-drupal.conf /etc/apache2/sites-enabled/000-default.conf


CMD ["sh", "-c", "/opt/drupal/docker/scripts/base.sh && apache2-foreground"]
