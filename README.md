# Inception - gmacias-
Este README proporciona una guía sobre cómo usar Docker y Docker Compose con el proyecto Inception de 42. Abarca desde comandos básicos hasta conceptos clave como Dockerfile, redes y volúmenes.

## Requisitos Previos

- **Docker**: Asegúrate de tener Docker instalado en tu máquina. Puedes descargarlo [aquí](https://www.docker.com/get-started).
- **Docker Compose**: Necesitarás Docker Compose para gestionar contenedores multi-servicio. [Descárgalo aquí](https://docs.docker.com/compose/install/).


## Comandos Básicos de Docker

Aquí tienes una lista de comandos básicos de Docker que te serán útiles para gestionar contenedores, imágenes, redes y volúmenes:

- **`docker stop <container_id>`**: Detiene un contenedor en ejecución.
- **`docker start <container_id>`**: Inicia un contenedor que está detenido.
- **`docker restart <container_id>`**: Reinicia un contenedor en ejecución.
- **`docker run <options> <image>`**: Ejecuta un nuevo contenedor basado en una imagen. Puedes añadir opciones como `-d` para ejecutar en segundo plano o `-p` para mapear puertos.
- **`docker exec -it <container_id> <command>`**: Ejecuta un comando en un contenedor en ejecución. Usa `-it` para interacción en modo terminal.
- **`docker ps`**: Muestra una lista de contenedores en ejecución.
- **`docker ps -a`**: Muestra todos los contenedores, incluidos los que están detenidos.
- **`docker rm <container_id>`**: Elimina un contenedor. Necesitarás detenerlo primero si está en ejecución.
- **`docker rmi <image_id>`**: Elimina una imagen. No puede ser utilizada si algún contenedor se basa en ella.
- **`docker images`**: Lista todas las imágenes disponibles localmente.
- **`docker network ls`**: Lista todas las redes Docker.
- **`docker volume ls`**: Lista todos los volúmenes Docker.
- **`docker stop $(docker ps -qa)`**: Detiene todos los contenedores en ejecución.
- **`docker rm $(docker ps -qa)`**: Elimina todos los contenedores (detenidos y en ejecución).
- **`docker rmi -f $(docker images -qa)`**: Elimina todas las imágenes (forzado).
- **`docker volume rm $(docker volume ls -q)`**: Elimina todos los volúmenes no utilizados.
- **`docker network rm $(docker network ls -q)`**: Elimina todas las redes no utilizadas.

Estos comandos te proporcionan un control básico sobre los elementos principales en Docker, permitiéndote gestionar contenedores, imágenes, redes y volúmenes de manera eficiente.

## Dockerfile

El `Dockerfile` define el entorno y los pasos para construir una imagen Docker. Aquí están algunas de las instrucciones más comunes:

- **`FROM`**: Especifica la imagen base sobre la que se construye la nueva imagen.
  ```dockerfile
  FROM ubuntu:20.04
  ```
- **`RUN`**: Ejecuta comandos dentro de la imagen durante la construcción.
  ```dockerfile
  RUN apt-get update && apt-get install -y nginx
  ```
- **`COPY`**: Copia archivos y directorios del contexto de construcción al sistema de archivos de la imagen.
  ```dockerfile
  COPY ./localfile /app/remote/
  ```
- **`WORKDIR`**: Establece el directorio de trabajo para las instrucciones `RUN`, `CMD`, `ENTRYPOINT`, `COPY`, y `ADD`.
  ```dockerfile
  # Establece el directorio de trabajo en /app
  WORKDIR /app
  ```
  
- **`EXPOSE`**: Documenta el puerto en el que el contenedor escuchará en tiempo de ejecución. No publica el puerto, solo sirve como documentación.
  ```dockerfile
  # Indica que el contenedor escuchará en el puerto 80
  EXPOSE 80
  ```

### Diferencia entre `ENTRYPOINT` y `CMD`

- **`ENTRYPOINT`**: Define el comando que se ejecutará siempre que el contenedor se inicie. No puede ser sobrescrito por argumentos en el comando `docker run`.
  ```dockerfile
  ENTRYPOINT ["nginx", "-g", "daemon off;"]
  ```

- **`CMD`**: Proporciona los argumentos por defecto para el comando definido en `ENTRYPOINT`, o define el comando a ejecutar si `ENTRYPOINT` no está especificado. Puede ser sobrescrito por argumentos en el comando `docker run`.
  ```dockerfile
  CMD ["-g", "daemon off;"]
  ```

## Diferencia entre Docker y Docker Compose

- **Docker**: Permite crear, ejecutar y gestionar contenedores individuales. Es ideal para aplicaciones que se ejecutan en un solo contenedor.
  
- **Docker Compose**: Es una herramienta que permite definir y ejecutar aplicaciones multicontenedor. Utiliza un archivo `docker-compose.yml` para configurar los servicios, redes y volúmenes necesarios.

## Beneficios de Docker vs Máquinas Virtuales (VMs)

- **Ligereza**: Los contenedores Docker comparten el núcleo del sistema operativo y son más ligeros que las VMs, que requieren un sistema operativo completo.
- **Velocidad**: Docker arranca y escala contenedores mucho más rápido que las VMs.
- **Portabilidad**: Los contenedores Docker son más portátiles, ya que incluyen todo lo necesario para ejecutar la aplicación, independientemente del entorno.

## Redes Docker dentro de Docker Compose


Docker Compose facilita la gestión de redes para que los contenedores puedan comunicarse entre sí de manera eficiente. Vamos a explorar cómo funcionan las redes en Docker Compose y cómo puedes personalizarlas.

Cuando usas Docker Compose, se crea una red por defecto para los servicios definidos en el archivo `docker-compose.yml`. Esta red permite que los contenedores se comuniquen entre sí utilizando los nombres de los servicios como nombres de host.


### Parámetros de Configuración de Redes

Aquí hay una descripción de los parámetros y opciones que puedes usar al definir redes en Docker Compose:

#### **driver**

El `driver` especifica el tipo de red que Docker debe crear. Algunos de los drivers más comunes son:

- **`bridge`**: El driver predeterminado para redes en Docker. Crea una red local en el host. Los contenedores conectados a la misma red `bridge` pueden comunicarse entre sí. Es útil para entornos de desarrollo o pruebas.
  ```yaml
  networks:
    frontend:
      driver: bridge
  ```

- **`host`**: Utiliza la red del host en lugar de crear una red aislada para el contenedor. Los contenedores no están aislados de la red del host y pueden afectar la red del host.
  ```yaml
  networks:
    hostnet:
      driver: host
  ```

- **`overlay`**: Utilizado en entornos de Docker Swarm para permitir la comunicación entre contenedores en diferentes hosts Docker. Este driver es útil para redes de clúster.
  ```yaml
  networks:
    swarmnet:
      driver: overlay
  ```

- **`none`**: El contenedor no estará conectado a ninguna red. Es útil para contenedores que no necesitan acceso de red.
  ```yaml
  networks:
    none:
      driver: none
  ```

#### **ipam**

`ipam` (IP Address Management) permite la configuración avanzada de direcciones IP para la red. Puedes definir rangos de direcciones IP y subredes. Ejemplo:

```yaml
networks:
  frontend:
    driver: bridge
    ipam:
      config:
        - subnet: 192.168.1.0/24
          gateway: 192.168.1.1
```

En este ejemplo:

- **`subnet`**: Define el rango de direcciones IP para la red.
- **`gateway`**: Define la puerta de enlace de la red.

#### **driver_opts**

Permite establecer opciones adicionales específicas del driver. Por ejemplo, para el driver `bridge`, puedes establecer opciones como el nombre del puente:

```yaml
networks:
  frontend:
    driver: bridge
    driver_opts:
      com.docker.network.bridge.name: my_custom_bridge
```

Claro, vamos a detallar cómo funcionan los volúmenes en Docker y explicar cada parámetro utilizando el ejemplo proporcionado. Aquí tienes una explicación más clara y detallada sobre los volúmenes en Docker:

---

## Volúmenes en Docker

Un volumen es una parte del sistema de archivos que se monta en uno o más contenedores. Los volúmenes permiten que los datos generados por los contenedores persistan más allá de la vida útil del contenedor y facilitan la gestión y el intercambio de datos.

### Ejemplo de Configuración de Volúmenes en `docker-compose.yml`

En un archivo `docker-compose.yml`, puedes definir volúmenes para los servicios de la siguiente manera:

```yaml
version: '3'
services:
  wordpress:
    image: wordpress
    volumes:
      - wordpress_data:/var/www/html

  mariadb:
    image: mariadb
    volumes:
      - mariadb_data:/var/lib/mysql

volumes:
  wordpress_data:
    driver: local
    driver_opts:
      type: none
      device: /home/gmacias-/data/wordpress
      o: bind

  mariadb_data:
    driver: local
    driver_opts:
      type: none
      device: /home/gmacias-/data/mariadb
      o: bind
```

### Explicación de Parámetros

1. **`wordpress_data` y `mariadb_data`**:
   - Estos son los nombres de los volúmenes definidos en la sección `volumes` del archivo `docker-compose.yml`. Los nombres se utilizan para referirse a estos volúmenes en los servicios.

2. **`driver: local`**:
   - Especifica el tipo de driver que Docker utiliza para gestionar el volumen. `local` es el controlador predeterminado que se utiliza para almacenar datos en el sistema de archivos local del host.

3. **`driver_opts`**:
   - Permite especificar opciones adicionales para el driver del volumen.

   - **`type: none`**:
     - Indica que no se utiliza un tipo de sistema de archivos específico. Esto es útil cuando se desea usar un directorio existente en el host como volumen.

   - **`device: /home/gmacias-/data/wordpress`** y **`device: /home/gmacias-/data/mariadb`**:
     - Especifica la ruta en el sistema de archivos del host que se utilizará para el volumen. Estos directorios se montan dentro de los contenedores en las rutas correspondientes (`/var/www/html` para WordPress y `/var/lib/mysql` para MariaDB).

   - **`o: bind`**:
     - Indica que el volumen debe estar vinculado a una ubicación específica en el sistema de archivos del host. Utiliza la opción de montaje `bind` para montar un directorio específico del host en el contenedor.

### Uso de Volúmenes

- **Persistencia de Datos**: Los datos almacenados en volúmenes persisten incluso si el contenedor se elimina. Esto es crucial para mantener bases de datos y otros archivos importantes.
- **Facilidad de Gestión**: Los volúmenes permiten que los datos sean fácilmente gestionables y accesibles desde el host, lo que facilita las copias de seguridad y la migración de datos.
- **Compartición entre Contenedores**: Los volúmenes pueden ser compartidos entre múltiples contenedores, permitiendo que diferentes servicios accedan a los mismos datos.

## Documentación de Contenedores Específicos

Para obtener detalles específicos sobre la configuración y el uso de cada contenedor incluido en este proyecto, consulta los siguientes archivos README:

- **MariaDB**: [README para MariaDB](https://github.com/gjmacias/Inception/tree/main/srcs/requirements/mariadb)
  - Detalles sobre la configuración de MariaDB, incluyendo la inicialización de la base de datos y la integración con aplicaciones como WordPress.

- **WordPress**: [README para WordPress](https://github.com/gjmacias/Inception/tree/main/srcs/requirements/wordpress)
  - Información sobre la configuración de WordPress, la instalación automática, y la integración con la base de datos.

- **Nginx**: [README para Nginx](https://github.com/gjmacias/Inception/tree/main/srcs/requirements/nginx)
  - Explicación sobre la configuración de Nginx para servir contenido a través de HTTPS y su integración con PHP-FPM.

Estos documentos proporcionan instrucciones detalladas sobre cómo cada contenedor está configurado y cómo se deben utilizar dentro del entorno general de la aplicación. Asegúrate de revisarlos para una comprensión completa del entorno y de cómo interactúan los diferentes componentes.

# Quizás pueda interesarte!

### - Perfil de GitHub gmacias-
[AQUÍ](https://github.com/gjmacias)

# Contactos 📥

◦ Email gmacias-: gmacias-@student.42barcelona.com

[1]: https://www.42barcelona.com/ "42 BCN"
