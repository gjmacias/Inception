all: set_host
	@ mkdir -p /mnt/c/Users/GG/Desktop/data/mariadb
	@ mkdir -p /mnt/c/Users/GG/Desktop/data/wordpress
	
	@docker compose -f ./srcs/docker-compose.yml up -d --build

set_host:
	@if ! grep -q "gmacias-.42.fr" /etc/hosts; then \
		echo "127.0.0.1 gmacias-.42.fr" >> ./hosts ;\
	fi

down:
	@docker compose -f ./srcs/docker-compose.yml down

re:
	@docker compose -f srcs/docker-compose.yml up -d --build

clean: down
	@docker rmi srcs-wordpress srcs-mariadb srcs-nginx
	@docker volume rm srcs_mariadb_data srcs_wordpress_data

vclean:
	@ rm -rf /mnt/c/Users/GG/Desktop/data/mariadb
	@ rm -rf /mnt/c/Users/GG/Desktop/data/wordpress

.PHONY: all set_host re down clean vclean