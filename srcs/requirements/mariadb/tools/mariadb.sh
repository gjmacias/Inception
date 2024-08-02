#!/bin/sh

# Initialize the database
mysqld --initialize-insecure --user=mysql

# Start MySQL server
mysqld_safe --skip-networking &
mysql_pid="$!"

# Esperar a que MySQL inicie
while ! mysqladmin ping --silent; do
	sleep 1
done

# Wait for MySQL to start
if [ -d "/var/lib/mysql/$MYSQL_DATABASE" ]; then
	echo "Database already exists"
else
# Set root password
	mysql -uroot << EOSQL
		ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';
		DELETE FROM mysql.user WHERE User='';
		DROP DATABASE IF EXISTS test;
		DELETE FROM mysql.db WHERE Db='test' OR Db='test\_%';
		FLUSH PRIVILEGES;
EOSQL

# Create database and user for WordPress
	mysql -uroot -p$MYSQL_ROOT_PASSWORD << EOSQL
		CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;
		CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
		GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';
		FLUSH PRIVILEGES;
EOSQL

# !!! Import WordPress Database !!!
    mysql -uroot -p$MYSQL_ROOT_PASSWORD $MYSQL_DATABASE < /usr/local/bin/wordpress.sql
fi

# Stop MySQL server
mysqladmin shutdown -p$MYSQL_ROOT_PASSWORD

# Run CMD
exec "$@"
