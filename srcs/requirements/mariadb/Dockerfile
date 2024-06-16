FROM	debian:buster

RUN		apt-get update && apt-get upgrade -y && \
		DEBIAN_FRONTEND=noninteractive apt-get install -y mariadb-server && \
		service mysql start

COPY	conf/50-server.cnf	/etc/mysql/mariadb.conf.d/50-server.cnf

COPY	conf/setup_db.sh /usr/local/bin/setup_db.sh

RUN		chmod +x /usr/local/bin/setup_db.sh
RUN		/usr/local/bin/setup_db.sh

CMD		["mysqld_safe"]
