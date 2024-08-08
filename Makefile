all: set_host
	@ sudo mkdir -p /home/gmacias-/data/mariadb
	@ sudo mkdir -p /home/gmacias-/data/wordpress
	
	@docker compose -f ./srcs/docker-compose.yml up -d --build

set_host:
	@if ! grep -q "gmacias.42.fr" /etc/hosts; then \
		sudo echo "127.0.0.1	gmacias.42.fr" | sudo tee -a /etc/hosts > /dev/null;\
	fi


down:
	@docker compose -f ./srcs/docker-compose.yml down


remove_host:
	@if grep -q "127.0.0.1	gmacias.42.fr" /etc/hosts; then \
		sudo sed -i '/127.0.0.1	gmacias.42.fr/d' /etc/hosts; \
	fi

clean: down remove_host 
	@docker rmi srcs-wordpress srcs-mariadb srcs-nginx
	@docker volume rm srcs_mariadb_data srcs_wordpress_data

vclean: 
	@ sudo rm -rf /home/gmacias-/data/mariadb
	@ sudo rm -rf /home/gmacias-/data/wordpress
	@if [ -z "$(ls -A /mnt/c/Users/GG/Desktop/data)" ]; then \
		sudo rm -rf /home/gmacias-/data; \
	fi

fclean: clean vclean


re: clean vclean all


.PHONY: all set_host down clean remove_host vclean fclean re
