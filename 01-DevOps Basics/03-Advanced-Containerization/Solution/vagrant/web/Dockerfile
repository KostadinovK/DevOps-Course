FROM php:fpm

# Install additional packages
RUN docker-php-ext-install pdo_mysql

# Adds the NGINX and Supervisor packages
RUN apt-get update -y && apt-get install -y nginx supervisor

# Removes the /etc/nginx/sites-{available,enabled} folders
RUN rm -rf /etc/nginx/sites-*

# Redirects the NGINX log (access and error) to stdout and stderr
RUN ln -sf /dev/stdout /var/log/nginx/access.log && ln -sf /dev/stderr /var/log/nginx/error.log

# Adds our specific configuration for NGINX
ADD nginx-php.conf /etc/nginx/conf.d/nginx-php.conf

# Adds configuration for Supervisor utility
ADD supervisor.conf /etc/supervisor.conf

# Copies our PHP application
ADD php/index.php /var/www/html/index.php

# Exposes port 80
EXPOSE 80

# Sets the routine to be executed when container is started
CMD ["supervisord", "-c", "/etc/supervisor.conf"]