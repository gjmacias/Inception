#!/bin/bash

# Ejecutar comandos SQL
mysql -e "CREATE DATABASE IF NOT EXISTS \`$SQL_DATABASE\`;"
mysql -e "USE \`$SQL_DATABASE\`; CREATE TABLE IF NOT EXISTS \`mytable\` (id INT AUTO_INCREMENT PRIMARY KEY, name VARCHAR(255));"
mysql -e "CREATE USER IF NOT EXISTS \`$SQL_USER\`@'localhost' IDENTIFIED BY '$SQL_PASSWORD';"
mysql -e "GRANT ALL PRIVILEGES ON \`$SQL_DATABASE\`.* TO \`$SQL_USER\`@'%';"
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$SQL_ROOT_PASSWORD';"
mysql -e "FLUSH PRIVILEGES;"

# Reiniciar MySQL/MariaDB para guardar los cambios
mysqladmin -u root -p"$SQL_ROOT_PASSWORD" shutdown