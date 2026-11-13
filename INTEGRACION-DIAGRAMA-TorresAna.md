# Integración del modelo de datos - TorresAna

## Compatibilidad
El backend original utiliza `BD_Gestion_Academica_v2`. Se conservó esa base y sus tablas existentes para no romper los CRUD actuales. La extensión `sql-TorresAna/02_extension_modelo_diagrama.sql` incorpora las tablas nuevas del diagrama de forma aditiva; no cambia el nombre de la base ni elimina columnas históricas.

## Nuevas tablas y API
- `guardian`: `/api/guardians` (GET, GET/{id}, POST, PUT/{id}, DELETE/{id})
- `student_guardian`: `/api/student-guardians` (GET, GET/{studentId}/{guardianId}, POST, DELETE/{studentId}/{guardianId})
- `section_course`: `/api/section-courses` (GET, GET/{id}, POST, PUT/{id}, DELETE/{id})
- `assessment`: `/api/assessments` (GET, GET/{id}, POST, PUT/{id}, DELETE/{id})

Los CRUD anteriores de estudiantes, docentes, matrículas, cursos, notas y asistencia se mantienen. Se agregan `assessment_id` a `grade_record` y `section_course_id` a `attendance` como columnas nullable para permitir migración progresiva sin invalidar datos históricos.

## Orden de despliegue
1. Respaldar `BD_Gestion_Academica_v2`.
2. Ejecutar `sql-TorresAna/02_extension_modelo_diagrama.sql` en una copia de desarrollo.
3. Desplegar el backend actualizado.
4. Configurar el frontend para apuntar a la URL del backend correspondiente.

## Sincronización
El servicio de estudiantes del frontend vuelve a consultar `/api/student` cada 15 segundos para reflejar cambios externos en SQL Server. Los formularios siguen usando los endpoints existentes. Las nuevas tablas tienen API lista, pero no se añadieron pantallas ni botones nuevos para ellas, para respetar el diseño solicitado. La sincronización periódica de todas las demás listas y la conexión de formularios específicos a las cuatro nuevas APIs requieren una siguiente fase de integración de UI/servicios.

## Verificación
- Backend: `./mvnw -DskipTests package` completó correctamente.
- Frontend: no se pudo ejecutar `npm ci` en este entorno por tiempo de espera; por ello, la compilación Angular queda pendiente de validación.
- No se ejecutó la migración en ninguna base de datos ni se modificó AWS.
