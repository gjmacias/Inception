# README para el Contenedor de Nginx

Este contenedor proporciona un servidor web Nginx configurado para servir aplicaciones a través de HTTPS. A continuación se describe cómo está configurado el contenedor y cómo utilizarlo.

## Descripción General

El contenedor se basa en Debian y está configurado para ejecutar Nginx con soporte SSL. Incluye una configuración personalizada para manejar solicitudes HTTPS y servir aplicaciones web, como WordPress.

### Funcionalidad del Contenedor

1. **Instalación de Nginx y Herramientas**
   - Se instala Nginx junto con herramientas útiles como `vim`, `curl` y `openssl`. También se generan certificados SSL para habilitar HTTPS en el servidor.

2. **Configuración de SSL**
   - Se crean certificados SSL auto-firmados para habilitar el protocolo HTTPS. Los certificados se almacenan en `/etc/nginx/ssl/` y se utilizan para cifrar las conexiones.

3. **Configuración del Servidor Nginx**
   - Se proporciona un archivo de configuración personalizado (`nginx.conf`) que define cómo Nginx debe manejar las solicitudes. Esto incluye la configuración para servir contenido a través de HTTPS y la integración con PHP-FPM para procesar solicitudes PHP.

4. **Exposición del Puerto**
   - El contenedor expone el puerto `443`, que es el puerto estándar para HTTPS. Esto permite que Nginx sirva contenido cifrado a través de la red.

## Archivos Clave

### `nginx.conf`

Este archivo de configuración define cómo Nginx debe manejar las solicitudes HTTPS:

- **Certificados SSL**: Configura Nginx para usar los certificados SSL (`gmacias-.crt` y `gmacias-.key`) para cifrar las conexiones HTTPS.
- **Configuración de Escucha**: Nginx escucha en el puerto `443` para conexiones SSL.
- **Directivas de Servidor**: Define el `server_name` y el `root` para la raíz del documento. También configura la manera en que Nginx maneja las solicitudes para archivos PHP, enviándolas al contenedor de PHP-FPM.
- **Seguridad**: Configura Nginx para denegar el acceso a archivos `.ht` por razones de seguridad.

## Notas Adicionales

- **Certificados SSL**: Los certificados SSL utilizados en este contenedor son auto-firmados. Para un entorno de producción, se recomienda usar certificados emitidos por una autoridad de certificación (CA) confiable.
- **Integración con PHP-FPM**: El archivo de configuración de Nginx está configurado para pasar solicitudes PHP al contenedor de PHP-FPM en el puerto `9000`, lo cual es útil para aplicaciones que requieren procesamiento PHP, como WordPress.
