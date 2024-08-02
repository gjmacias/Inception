FROM	debian:buster

# Update and install necessary dependencies
RUN		apt-get update && apt upgrade -y \
		&& apt-get install -y wget curl bash \
		php php-cgi php-mysql php-fpm php-pdo php-gd php-cli php-mbstring \
		&& rm -rf /var/lib/apt/lists/*

# Download and configure WP-CLI
RUN		wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
		&& chmod +x wp-cli.phar \
		&& mv wp-cli.phar /usr/local/bin/wp

# Copy custom PHP configuration 	WATCH VERISON!!!
COPY	conf/www.conf				/etc/php/7.3/fpm/pool.d/www.conf

# Create the necessary directory for PHP-FPM
RUN		mkdir /run/php

# Copy the WordPress creation script and give it execute permissions
COPY	./tools/config_wordpress.sh	/usr/local/bin/
RUN		chmod +x /usr/local/bin/config_wordpress.sh

# Set the working directory
WORKDIR	/var/www/html/

# Expose the required port
EXPOSE	9000

# Set the entry point to run the script and then start PHP-FPM
ENTRYPOINT	["/usr/local/bin/config_wordpress.sh"]

# Start PHP-FPM in foreground	WATCH VERISON!!!
CMD			["php-fpm7.3", "-F"]
