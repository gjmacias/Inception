FROM	debian:bullseye

# Update and install nginx + utilities program
RUN		apt update -y && apt upgrade -y && \
		apt install -y nginx vim curl openssl && \
		mkdir -p /etc/nginx/ssl /run/nginx && \
		openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
			-out /etc/nginx/ssl/gmacias-.crt \
			-keyout /etc/nginx/ssl/gmacias-.key \
			-subj "/C=FR/ST=Paris/L=Paris/O=42/OU=gmacias-/CN=gmacias-/"

# Clone my conf/ into docker nginx
COPY	./conf/nginx.conf /etc/nginx/conf.d

# The only port allowed
EXPOSE	443

# Start nginx
CMD		["nginx", "-g", "daemon off;"]
