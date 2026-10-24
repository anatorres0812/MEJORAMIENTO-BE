# Manual de despliegue - TorresAna

## 1. Objetivo

Documentar la preparación, construcción y despliegue del backend
del sistema de gestión académica.

## 2. Componentes

- Backend Spring Boot.
- Base de datos SQL Server.
- Imagen Docker del backend.
- Docker Compose para el entorno de contenedores.
- GitHub Actions para automatizar la construcción y publicación.

## 3. Configuración pendiente

Antes del despliegue se deben verificar:

- La versión de Java y las dependencias Maven.
- La estructura real de la base de datos.
- Las variables de entorno necesarias.
- Los puertos y las redes entre contenedores.
- Los secretos de Docker Hub y AWS.

## 4. Seguridad

No publicar contraseñas, tokens ni claves privadas.
La base de datos debe permanecer protegida y no exponerse públicamente
sin una necesidad justificada.

## 5. Procedimiento

Las instrucciones ejecutables se incorporarán después de validar
el Dockerfile, Docker Compose, la conexión a SQL Server y la aplicación.