/*
  RESET-AND-SEED.sql - TorresAna
  ADVERTENCIA: este script ELIMINA los datos existentes de las tablas de negocio
  de BD_Gestion_Academica_v2 y vuelve a insertar datos de demostración.
  Ejecutar solo en desarrollo/pruebas, después de DB.sql.
*/
USE BD_Gestion_Academica_v2;
GO
SET NOCOUNT ON;
SET XACT_ABORT ON;
GO

BEGIN TRY
  BEGIN TRANSACTION;

  -- Borrar en orden inverso a las dependencias de claves foráneas.
  DELETE FROM dbo.grade_record;
  DELETE FROM dbo.attendance;
  DELETE FROM dbo.enrollment;
  DELETE FROM dbo.Copy_of_curse__grade;
  DELETE FROM dbo.Copy_of_Competency;
  DELETE FROM dbo.Copy_of_course;
  DELETE FROM dbo.Competency;
  DELETE FROM dbo.course;
  DELETE FROM dbo.classroom;
  DELETE FROM dbo.student;
  DELETE FROM dbo.academic_period;
  DELETE FROM dbo.teacher;
  DELETE FROM dbo.section;
  DELETE FROM dbo.grade;
  DELETE FROM dbo.audit_log;

  -- Restablecer identidades para que la demo comience desde 1.
  DBCC CHECKIDENT ('dbo.grade', RESEED, 0);
  DBCC CHECKIDENT ('dbo.section', RESEED, 0);
  DBCC CHECKIDENT ('dbo.teacher', RESEED, 0);
  DBCC CHECKIDENT ('dbo.classroom', RESEED, 0);
  DBCC CHECKIDENT ('dbo.academic_period', RESEED, 0);
  DBCC CHECKIDENT ('dbo.student', RESEED, 0);
  DBCC CHECKIDENT ('dbo.course', RESEED, 0);
  DBCC CHECKIDENT ('dbo.Competency', RESEED, 0);
  DBCC CHECKIDENT ('dbo.enrollment', RESEED, 0);
  DBCC CHECKIDENT ('dbo.attendance', RESEED, 0);
  DBCC CHECKIDENT ('dbo.grade_record', RESEED, 0);
  DBCC CHECKIDENT ('dbo.Copy_of_course', RESEED, 0);
  DBCC CHECKIDENT ('dbo.Copy_of_Competency', RESEED, 0);
  DBCC CHECKIDENT ('dbo.Copy_of_curse__grade', RESEED, 0);
  DBCC CHECKIDENT ('dbo.audit_log', RESEED, 0);

  -- Catálogos
  INSERT dbo.grade (grade_name, education_level, grade_order, description) VALUES
   (N'Primero',N'PRIMARIA',1,N'Primer grado de primaria'),
   (N'Segundo',N'PRIMARIA',2,N'Segundo grado de primaria'),
   (N'Tercero',N'PRIMARIA',3,N'Tercer grado de primaria'),
   (N'Cuarto',N'PRIMARIA',4,N'Cuarto grado de primaria'),
   (N'Quinto',N'PRIMARIA',5,N'Quinto grado de primaria');

  INSERT dbo.section (section_name, capacity, shift) VALUES
   (N'A',30,N'MAÑANA'),(N'B',30,N'MAÑANA'),(N'C',28,N'TARDE'),
   (N'D',28,N'TARDE'),(N'E',25,N'COMPLETO');

  INSERT dbo.teacher (document_type,document_number,first_name,last_name,specialty,education_level,phone,email,hire_date) VALUES
   (N'DNI',N'70000001',N'Ana',N'Torres',N'Matemática',N'PRIMARIA',N'999111001',N'ana.torres@example.com','2020-03-01'),
   (N'DNI',N'70000002',N'Luis',N'Paredes',N'Comunicación',N'PRIMARIA',N'999111002',N'luis.paredes@example.com','2021-03-01'),
   (N'DNI',N'70000003',N'María',N'Rojas',N'Ciencia y Tecnología',N'PRIMARIA',N'999111003',N'maria.rojas@example.com','2019-03-01'),
   (N'DNI',N'70000004',N'José',N'Flores',N'Personal Social',N'PRIMARIA',N'999111004',N'jose.flores@example.com','2018-03-01'),
   (N'DNI',N'70000005',N'Elena',N'Vega',N'Inglés',N'PRIMARIA',N'999111005',N'elena.vega@example.com','2022-03-01');

  INSERT dbo.academic_period (period_name,academic_year,start_date,end_date,is_active) VALUES
   (N'Primer bimestre',2026,'2026-03-01','2026-05-15',1),
   (N'Segundo bimestre',2026,'2026-05-16','2026-07-31',0),
   (N'Tercer bimestre',2026,'2026-08-01','2026-10-15',0),
   (N'Cuarto bimestre',2026,'2026-10-16','2026-12-20',0),
   (N'Anual',2026,'2026-03-01','2026-12-20',0);

  INSERT dbo.course (code,course_name,description,education_level) VALUES
   (N'MAT-PRI',N'Matemática',N'Pensamiento matemático',N'PRIMARIA'),
   (N'COM-PRI',N'Comunicación',N'Comprensión y producción de textos',N'PRIMARIA'),
   (N'CYT-PRI',N'Ciencia y Tecnología',N'Indagación científica',N'PRIMARIA'),
   (N'PS-PRI',N'Personal Social',N'Ciudadanía e historia',N'PRIMARIA'),
   (N'ING-PRI',N'Inglés',N'Idioma extranjero',N'PRIMARIA');

  INSERT dbo.Competency (code,competency_name,description,education_level) VALUES
   (N'MAT-C01',N'Resuelve problemas de cantidad',N'Competencia matemática',N'PRIMARIA'),
   (N'COM-C01',N'Lee diversos tipos de textos',N'Comprensión lectora',N'PRIMARIA'),
   (N'CYT-C01',N'Indaga mediante métodos científicos',N'Indagación',N'PRIMARIA'),
   (N'PS-C01',N'Construye su identidad',N'Desarrollo personal',N'PRIMARIA'),
   (N'ING-C01',N'Se comunica en inglés',N'Comunicación en idioma extranjero',N'PRIMARIA');

  -- Aulas, estudiantes y matrículas vinculadas.
  INSERT dbo.classroom (code,classroom_name,education_level,academic_year,grade_id,section_id,capacity,teacher_id) VALUES
   (N'PRI1-A',N'Primero A',N'PRIMARIA',2026,1,1,30,1),
   (N'PRI2-B',N'Segundo B',N'PRIMARIA',2026,2,2,30,2),
   (N'PRI3-C',N'Tercero C',N'PRIMARIA',2026,3,3,28,3),
   (N'PRI4-D',N'Cuarto D',N'PRIMARIA',2026,4,4,28,4),
   (N'PRI5-E',N'Quinto E',N'PRIMARIA',2026,5,5,25,5);

  INSERT dbo.student (code,document_type,document_number,first_name,last_name,birth_date,gender,guardian_name,guardian_phone,guardian_last_name,guardian_relationship,education_level,grade_id,section_id) VALUES
   (N'EST-001',N'DNI',N'80000001',N'Sofía',N'García','2016-04-10',N'F',N'Carlos',N'988111001',N'García',N'Padre',N'PRIMARIA',1,1),
   (N'EST-002',N'DNI',N'80000002',N'Mateo',N'Quispe','2015-06-21',N'M',N'Rosa',N'988111002',N'Quispe',N'Madre',N'PRIMARIA',2,2),
   (N'EST-003',N'DNI',N'80000003',N'Valeria',N'Mendoza','2014-08-02',N'F',N'Pedro',N'988111003',N'Mendoza',N'Padre',N'PRIMARIA',3,3),
   (N'EST-004',N'DNI',N'80000004',N'Diego',N'Castro','2013-01-15',N'M',N'Lucía',N'988111004',N'Castro',N'Madre',N'PRIMARIA',4,4),
   (N'EST-005',N'DNI',N'80000005',N'Camila',N'Vargas','2012-11-09',N'F',N'Jorge',N'988111005',N'Vargas',N'Padre',N'PRIMARIA',5,5);

  INSERT dbo.enrollment (student_id,education_level,grade_id,section_id,academic_period_id,academic_year,enrollment_date,guardian_first_name,guardian_last_name,guardian_relationship,guardian_phone) VALUES
   (1,N'PRIMARIA',1,1,1,2026,'2026-03-02',N'Carlos',N'García',N'Padre',N'988111001'),
   (2,N'PRIMARIA',2,2,1,2026,'2026-03-02',N'Rosa',N'Quispe',N'Madre',N'988111002'),
   (3,N'PRIMARIA',3,3,1,2026,'2026-03-02',N'Pedro',N'Mendoza',N'Padre',N'988111003'),
   (4,N'PRIMARIA',4,4,1,2026,'2026-03-02',N'Lucía',N'Castro',N'Madre',N'988111004'),
   (5,N'PRIMARIA',5,5,1,2026,'2026-03-02',N'Jorge',N'Vargas',N'Padre',N'988111005');

  INSERT dbo.attendance (enrollment_id,course_id,academic_period_id,teacher_id,attendance_date,attendance_status,observation) VALUES
   (1,1,1,1,'2026-03-03',N'PRESENT',N'Asistencia registrada'),
   (2,2,1,2,'2026-03-03',N'PRESENT',N'Asistencia registrada'),
   (3,3,1,3,'2026-03-03',N'TARDY',N'Llegó tarde'),
   (4,4,1,4,'2026-03-03',N'PRESENT',N'Asistencia registrada'),
   (5,5,1,5,'2026-03-03',N'EXCUSED',N'Justificación presentada');

  INSERT dbo.grade_record (enrollment_id,competency_id,course_id,academic_period_id,teacher_id,grade_values,observation,recorded_date) VALUES
   (1,1,1,1,1,18.00,N'Buen desempeño','2026-05-10'),
   (2,2,2,1,2,17.50,N'Buen avance','2026-05-10'),
   (3,3,3,1,3,16.00,N'En progreso','2026-05-10'),
   (4,4,4,1,4,19.00,N'Destacado','2026-05-10'),
   (5,5,5,1,5,18.50,N'Destacado','2026-05-10');

  INSERT dbo.Copy_of_course (code,course_name,description,education_level,teacher_id) VALUES
   (N'LEG-MAT',N'Matemática (legado)',N'Datos de compatibilidad',N'PRIMARIA',1),
   (N'LEG-COM',N'Comunicación (legado)',N'Datos de compatibilidad',N'PRIMARIA',2),
   (N'LEG-CYT',N'Ciencia (legado)',N'Datos de compatibilidad',N'PRIMARIA',3),
   (N'LEG-PS',N'Personal Social (legado)',N'Datos de compatibilidad',N'PRIMARIA',4),
   (N'LEG-ING',N'Inglés (legado)',N'Datos de compatibilidad',N'PRIMARIA',5);

  INSERT dbo.Copy_of_Competency (code,competency_name,description,course_id,education_level) VALUES
   (N'LEG-C01',N'Competencia legado 1',N'Demo',1,N'PRIMARIA'),
   (N'LEG-C02',N'Competencia legado 2',N'Demo',2,N'PRIMARIA'),
   (N'LEG-C03',N'Competencia legado 3',N'Demo',3,N'PRIMARIA'),
   (N'LEG-C04',N'Competencia legado 4',N'Demo',4,N'PRIMARIA'),
   (N'LEG-C05',N'Competencia legado 5',N'Demo',5,N'PRIMARIA');

  INSERT dbo.Copy_of_curse__grade (grade_id,course_id) VALUES (1,1),(2,2),(3,3),(4,4),(5,5);

  COMMIT TRANSACTION;
END TRY
BEGIN CATCH
  IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
  THROW;
END CATCH;
GO

-- Resumen de registros después de la carga.
SELECT N'grade' AS tabla, COUNT_BIG(*) AS registros FROM dbo.grade UNION ALL
SELECT N'section', COUNT_BIG(*) FROM dbo.section UNION ALL
SELECT N'teacher', COUNT_BIG(*) FROM dbo.teacher UNION ALL
SELECT N'classroom', COUNT_BIG(*) FROM dbo.classroom UNION ALL
SELECT N'academic_period', COUNT_BIG(*) FROM dbo.academic_period UNION ALL
SELECT N'student', COUNT_BIG(*) FROM dbo.student UNION ALL
SELECT N'course', COUNT_BIG(*) FROM dbo.course UNION ALL
SELECT N'Competency', COUNT_BIG(*) FROM dbo.Competency UNION ALL
SELECT N'enrollment', COUNT_BIG(*) FROM dbo.enrollment UNION ALL
SELECT N'attendance', COUNT_BIG(*) FROM dbo.attendance UNION ALL
SELECT N'grade_record', COUNT_BIG(*) FROM dbo.grade_record UNION ALL
SELECT N'Copy_of_course', COUNT_BIG(*) FROM dbo.Copy_of_course UNION ALL
SELECT N'Copy_of_Competency', COUNT_BIG(*) FROM dbo.Copy_of_Competency UNION ALL
SELECT N'Copy_of_curse__grade', COUNT_BIG(*) FROM dbo.Copy_of_curse__grade;
GO
