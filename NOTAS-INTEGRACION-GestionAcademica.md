# Integración TorresAna — GestionAcademica

- Base de datos objetivo: `GestionAcademica`.
- SQL oficial: `database-reference/GestionAcademica.sql` (copia byte por byte del archivo entregado; no modificar).
- Puerto Spring interno: `8085`; publicación habitual del contenedor: `8080:8085`.
- Hibernate: `ddl-auto=none`; la aplicación no crea ni altera el esquema.
- Conexión por variables: `SPRING_DATASOURCE_URL`, `SPRING_DATASOURCE_USERNAME`, `SPRING_DATASOURCE_PASSWORD`.
- Compose backend-only: `docker-compose-TorresAna/docker-compose-be.yml`. Se conecta al SQL Server existente y NO crea un contenedor de base de datos.
- `docker-compose-db.yml` no debe ejecutarse en AWS si se conservará el contenedor SQL Server actual.
- Los scripts bajo `legacy-no-ejecutar` pertenecen al esquema anterior y no deben ejecutarse.

## Contacto

Se añadió `POST /api/contacto`, que guarda en `dbo.contact_message` con validaciones alineadas a las restricciones del SQL (nombre, correo `.com`/`.edu.pe`, asunto y mensaje).

## Configuración del despliegue

En el host backend, define `DB_HOST` con la IP privada actual del contenedor/servidor SQL, `DB_USER` y `DB_PASSWORD`. No guardar contraseñas reales en el repositorio. La IP predeterminada de ejemplo es `10.0.6.50`; confirmar que siga siendo la actual antes de levantar.
