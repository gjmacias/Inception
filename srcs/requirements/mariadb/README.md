# README para el Contenedor de MariaDB

Este contenedor proporciona una instancia de MariaDB configurada para su uso, ideal para aplicaciones como WordPress. A continuación se explica cómo está configurado el contenedor y cómo utilizarlo.

## Descripción General

El contenedor de MariaDB se basa en Debian y está diseñado para ofrecer una base de datos funcional con configuración inicial específica. A continuación, se detalla cómo se configura y utiliza el contenedor.

### Funcionalidad del Contenedor

1. **Configuración Inicial de MariaDB**
   - El contenedor instala MariaDB y configura el entorno necesario para ejecutar el servidor de base de datos. Esto incluye la creación de directorios y la configuración de permisos.

2. **Archivo de Configuración**
   - Se proporciona un archivo de configuración (`mysqld.cnf`) que define cómo debe funcionar el servidor de MariaDB. Esto incluye la dirección en la que el servidor escuchará las conexiones y otros parámetros clave.

3. **Inicialización de la Base de Datos**
   - Al iniciar el contenedor, se ejecuta un script (`mariadb.sh`) que inicializa la base de datos. El script configura el usuario root y crea una base de datos específica para la aplicación, como WordPress, si aún no existe. También importa datos iniciales desde un archivo SQL (`my_wordpress.sql`).

4. **Exposición de Puertos**
   - El contenedor expone el puerto `3306`, que es el puerto predeterminado para MariaDB. Esto permite que la base de datos sea accesible desde el exterior del contenedor.

## Archivos Clave

### `mariadb.sh`

Este script realiza las siguientes tareas:

- **Inicializa la Base de Datos**: Configura MariaDB para el primer uso.
- **Configura el Usuario Root**: Establece la contraseña del usuario root y limpia usuarios no deseados.
- **Crea una Base de Datos y Usuario**: Crea una base de datos y un usuario específico para aplicaciones como WordPress.
- **Importa Datos Iniciales**: Carga datos iniciales desde un archivo SQL si la base de datos no existe.

### `mysqld.cnf`

Este archivo de configuración define cómo debe comportarse el servidor de MariaDB, incluyendo:

- **Puerto de Escucha**: El puerto `3306` donde MariaDB escuchará las conexiones.
- **Configuración de Red**: Permite conexiones desde cualquier dirección IP (`bind-address=0.0.0.0`).

### `my_wordpress.sql`

Este archivo contiene la estructura y datos iniciales para la base de datos de WordPress. Se importa al contenedor durante la inicialización para configurar la base de datos con la información necesaria para WordPress.
