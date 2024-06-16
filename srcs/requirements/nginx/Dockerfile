FROM	debian:buster

RUN		apt update -y && apt upgrade -y && \
		apt install -y nginx vim curl openssl && \
		mkdir -p /etc/nginx/ssl /var/run/nginx && \
		openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=login.42.fr/UID=login"

RUN 	chmod 755 /var/www/html && \
		chown -R www-data:www-data /var/www/html

COPY	conf/nginx.conf /etc/nginx/nginx.conf

CMD		["nginx", "-g", "daemon off;"]
