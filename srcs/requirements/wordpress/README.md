# README para el Contenedor de WordPress

Este contenedor proporciona una instancia de WordPress lista para usar, configurada para trabajar con una base de datos MariaDB. A continuación se describe cómo está configurado el contenedor y cómo utilizarlo.

## Descripción General

El contenedor se basa en Debian y está configurado para ejecutar una instalación de WordPress con PHP y sus extensiones necesarias. Además, incluye herramientas para automatizar la configuración inicial de WordPress.

### Funcionalidad del Contenedor

1. **Instalación de Dependencias**
   - El contenedor instala las dependencias necesarias para ejecutar WordPress, incluyendo PHP y sus extensiones, así como herramientas de red como `wget` y `curl`.

2. **Configuración de WP-CLI**
   - Se instala WP-CLI, una herramienta de línea de comandos para gestionar WordPress. Esto facilita la administración de la instalación de WordPress.

3. **Configuración de PHP-FPM**
   - Se configura PHP-FPM para manejar las solicitudes PHP. Esto incluye la creación de directorios necesarios y la copia de configuraciones personalizadas.

4. **Automatización de la Configuración de WordPress**
   - Un script de inicialización (`config_wordpress.sh`) se encarga de descargar y configurar WordPress, estableciendo el archivo `wp-config.php` con las variables de entorno adecuadas.

5. **Exposición de Puertos**
   - El contenedor expone el puerto `9000`, que es utilizado por PHP-FPM para manejar solicitudes PHP.

## Archivos Clave

### `config_wordpress.sh`

Este script realiza las siguientes tareas al iniciar el contenedor:

- **Verifica la Instalación de WordPress**: Comprueba si `wp-config.php` ya existe para evitar volver a descargar WordPress innecesariamente.
- **Descarga y Configura WordPress**: Descarga la última versión de WordPress, descomprime el archivo y mueve los archivos necesarios al directorio de trabajo.
- **Configura el Archivo `wp-config.php`**: Sustituye los valores predeterminados en `wp-config-sample.php` con las variables de entorno proporcionadas (como el nombre de usuario y la contraseña de la base de datos) y lo renombra a `wp-config.php`.

### `www.conf`

Este archivo de configuración de PHP-FPM define:

- **Configuración de Usuario y Grupo**: PHP-FPM se ejecuta bajo el usuario y grupo `www-data`.
- **Configuración de Escucha**: PHP-FPM escucha en todas las interfaces en el puerto `9000`.
- **Parámetros de Gestión de Procesos**: Ajusta cómo PHP-FPM maneja los procesos, incluyendo el número máximo de hijos y servidores de inicio.
