FROM	debian:buster

RUN		apt-get update && apt upgrade -y && \
		apt-get install -y wget gnupg2 lsb-release apt-transport-https \
		ca-certificates php7.3 php7.3-fpm php7.3-mysql mariadb-client && \
		apt-get clean && rm -rf /var/lib/apt/lists/*

RUN		wget https://wordpress.org/wordpress-5.8-en_US.tar.gz -P /var/www && \
		cd /var/www && \
		tar -xzf wordpress-5.8-en_US.tar.gz && \
		rm wordpress-5.8-en_US.tar.gz && \
		chown -R www-data:www-data /var/www/wordpress

RUN		wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
		chmod +x wp-cli.phar && \
		mv wp-cli.phar /usr/local/bin/wp

COPY	conf/www.conf /etc/php/7.3/fpm/pool.d/www.conf
COPY	conf/auto_config.sh /conf/auto_config.sh

RUN		chmod +x /conf/auto_config.sh
RUN		/conf/auto_config.sh

CMD ["php-fpm7.3", "-F"]
