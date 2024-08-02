FROM	debian:buster

# Install required packages and clean up package lists
RUN		apt-get update && apt-get upgrade -y \
		&& apt-get install -y mariadb-server mariadb-client vim \
		&& rm -rf /var/lib/apt/lists/*

# Configure MariaDB
RUN		mkdir -p /var/run/mysqld \
		&& chown -R mysql:mysql	/var/run/mysqld \
		&& chmod 755 /var/run/mysqld

EXPOSE	3306

# Copy necessary scripts and configuration files
COPY	./tools/mariadb.sh		/usr/local/bin/
COPY	./conf/mysqld.cnf		/etc/mysql/mariadb.conf.d/

# Ensure that scripts have the necessary execution permissions
RUN		chmod +x /usr/local/bin/mariadb.sh
RUN		chmod 644 /etc/mysql/mariadb.conf.d/mysqld.cnf

# Use ENTRYPOINT for the script and CMD for start process
ENTRYPOINT	["/usr/local/bin/mariadb.sh"]

CMD			["mysqld", "--bind-address=0.0.0.0"]