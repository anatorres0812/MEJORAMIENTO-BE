/* ================================================================

   SISTEMA DE GESTION ACADEMICA - GestionAcademica

   SQL Server 2022 / 2025



   Incluye:

   1 ) Creacion de la base de datos

   2 ) 15 tablas y sus PK/FK/restricciones

   3 ) Datos de prueba relacionados

   4 ) Indices

   5 ) 3 vistas

   6 ) Triggers de validacion de notas (INSERT y UPDATE)

   7 ) Consultas JOIN y consultas de verificacion



   IMPORTANTE:

   - Este script NO elimina la base de datos ni sus tablas.

   - Esta preparado para una base nueva llamada GestionAcademica.

   - Si ya existen tablas con nombres iguales, revisa su estructura antes

     de ejecutar: el script no las elimina ni las recrea.

   ================================================================ */



/* 0. CREAR Y SELECCIONAR LA BASE DE DATOS */

IF DB_ID(N'GestionAcademica') IS NULL

BEGIN

    CREATE DATABASE GestionAcademica;

END;

GO



USE GestionAcademica;

GO



/* ================================================================

   1. TABLAS MAESTRAS (9)

   ================================================================ */



/* 1. academic_period: periodos academicos */

IF OBJECT_ID(N'dbo.academic_period', N'U') IS NULL

BEGIN

    CREATE TABLE dbo.academic_period (

        academic_period_id INT IDENTITY(1,1) NOT NULL,

        period_name NVARCHAR(100) NOT NULL,

        academic_year SMALLINT NOT NULL,

        start_date DATE NOT NULL,

        end_date DATE NOT NULL,

        status VARCHAR(15) NOT NULL CONSTRAINT DF_academic_period_status DEFAULT ('ACTIVO'),

        created_at DATETIME2 NOT NULL CONSTRAINT DF_academic_period_created DEFAULT (SYSDATETIME()),

        updated_at DATETIME2 NULL,

        CONSTRAINT PK_academic_period PRIMARY KEY (academic_period_id),

        CONSTRAINT CK_academic_period_dates CHECK (end_date >= start_date)

  );

END;

GO



/* 2. grade_level: grados */

IF OBJECT_ID(N'dbo.grade_level', N'U') IS NULL

BEGIN

    CREATE TABLE dbo.grade_level (

        grade_id INT IDENTITY(1,1) NOT NULL,

        grade_name NVARCHAR(100) NOT NULL,

        education_level NVARCHAR(50) NOT NULL,

        grade_order SMALLINT NOT NULL,

        status VARCHAR(15) NOT NULL CONSTRAINT DF_grade_level_status DEFAULT ('ACTIVO'),

        CONSTRAINT PK_grade_level PRIMARY KEY (grade_id)

  );

END;

GO



/* 3. classroom: aulas */

IF OBJECT_ID(N'dbo.classroom', N'U') IS NULL

BEGIN

    CREATE TABLE dbo.classroom (

        classroom_id INT IDENTITY(1,1) NOT NULL,

        code VARCHAR(30) NOT NULL,

        classroom_name NVARCHAR(100) NOT NULL,

        capacity SMALLINT NOT NULL,

        status VARCHAR(15) NOT NULL CONSTRAINT DF_classroom_status DEFAULT ('ACTIVO'),

        CONSTRAINT PK_classroom PRIMARY KEY (classroom_id),

        CONSTRAINT UQ_classroom_code UNIQUE (code),

        CONSTRAINT CK_classroom_capacity CHECK (capacity > 0)

  );

END;

GO



/* 4. student: student_id es el codigo manual del estudiante, NO IDENTITY */

IF OBJECT_ID(N'dbo.student', N'U') IS NULL

BEGIN

    CREATE TABLE dbo.student (

        student_id INT NOT NULL,

        document_type VARCHAR(10) NOT NULL,

        document_number VARCHAR(20) NOT NULL,

        first_name NVARCHAR(100) NOT NULL,

        last_name NVARCHAR(100) NOT NULL,

        birth_date DATE NOT NULL,

        gender CHAR(1) NULL,

        status VARCHAR(15) NOT NULL CONSTRAINT DF_student_status DEFAULT ('ACTIVO'),

        created_at DATETIME2 NOT NULL CONSTRAINT DF_student_created DEFAULT (SYSDATETIME()),

        updated_at DATETIME2 NULL,

        CONSTRAINT PK_student PRIMARY KEY (student_id),

        CONSTRAINT UQ_student_document UNIQUE (document_number),

        CONSTRAINT CK_student_gender CHECK (gender IS NULL OR gender IN ('M','F','O'))

  );

END;

GO



/* 5. guardian: apoderados */

IF OBJECT_ID(N'dbo.guardian', N'U') IS NULL

BEGIN

    CREATE TABLE dbo.guardian (

        guardian_id INT IDENTITY(1,1) NOT NULL,

        document_type VARCHAR(10) NOT NULL,

        document_number VARCHAR(20) NOT NULL,

        first_name NVARCHAR(100) NOT NULL,

        last_name NVARCHAR(100) NOT NULL,

        phone VARCHAR(20) NOT NULL,

        email NVARCHAR(150) NULL,

        created_at DATETIME2 NOT NULL CONSTRAINT DF_guardian_created DEFAULT (SYSDATETIME()),

        updated_at DATETIME2 NULL,

        CONSTRAINT PK_guardian PRIMARY KEY (guardian_id),

        CONSTRAINT UQ_guardian_document UNIQUE (document_number)

  );

END;

GO



/* 6. teacher: docentes */

IF OBJECT_ID(N'dbo.teacher', N'U') IS NULL

BEGIN

    CREATE TABLE dbo.teacher (

        teacher_id INT IDENTITY(1,1) NOT NULL,

        document_type VARCHAR(10) NOT NULL,

        document_number VARCHAR(20) NOT NULL,

        first_name NVARCHAR(100) NOT NULL,

        last_name NVARCHAR(100) NOT NULL,

        specialty NVARCHAR(150) NULL,

        education_level NVARCHAR(100) NULL,

        phone VARCHAR(20) NULL,

        email NVARCHAR(150) NULL,

        hire_date DATE NULL,

        status VARCHAR(15) NOT NULL CONSTRAINT DF_teacher_status DEFAULT ('ACTIVO'),

        created_at DATETIME2 NOT NULL CONSTRAINT DF_teacher_created DEFAULT (SYSDATETIME()),

        updated_at DATETIME2 NULL,

        CONSTRAINT PK_teacher PRIMARY KEY (teacher_id),

        CONSTRAINT UQ_teacher_document UNIQUE (document_number)

  );

END;

GO



/* 7. course: cursos */

IF OBJECT_ID(N'dbo.course', N'U') IS NULL

BEGIN

    CREATE TABLE dbo.course (

        course_id INT IDENTITY(1,1) NOT NULL,

        course_name NVARCHAR(150) NOT NULL,

        description NVARCHAR(500) NULL,

        status VARCHAR(15) NOT NULL CONSTRAINT DF_course_status DEFAULT ('ACTIVO'),

        created_at DATETIME2 NOT NULL CONSTRAINT DF_course_created DEFAULT (SYSDATETIME()),

        updated_at DATETIME2 NULL,

        CONSTRAINT PK_course PRIMARY KEY (course_id)

  );

END;

GO



/* 8. competency: competencias asociadas a un curso */

IF OBJECT_ID(N'dbo.competency', N'U') IS NULL

BEGIN

    CREATE TABLE dbo.competency (

        competency_id INT IDENTITY(1,1) NOT NULL,

        course_id INT NOT NULL,

        competency_name NVARCHAR(200) NOT NULL,

        description NVARCHAR(200) NULL,

        status VARCHAR(15) NOT NULL CONSTRAINT DF_competency_status DEFAULT ('ACTIVO'),

        created_at DATETIME2 NOT NULL CONSTRAINT DF_competency_created DEFAULT (SYSDATETIME()),

        updated_at DATETIME2 NULL,

        CONSTRAINT PK_competency PRIMARY KEY (competency_id),

        CONSTRAINT FK_competency_course FOREIGN KEY (course_id) REFERENCES dbo.course(course_id),

        CONSTRAINT UQ_competency_course_name UNIQUE (course_id, competency_name)

  );

END;

GO



/* ================================================================

   2. TABLAS TRANSACCIONALES (6)

   ================================================================ */



/* 9. section: secciones (tabla maestra) */

IF OBJECT_ID(N'dbo.section', N'U') IS NULL

BEGIN

    CREATE TABLE dbo.section (

        section_id BIGINT IDENTITY(1,1) NOT NULL,

        section_name NVARCHAR(50) NOT NULL,

        grade_id INT NOT NULL,

        academic_period_id INT NOT NULL,

        classroom_id INT NOT NULL,

        shift VARCHAR(15) NOT NULL,

        capacity SMALLINT NOT NULL,

        status VARCHAR(15) NOT NULL CONSTRAINT DF_section_status DEFAULT ('ACTIVO'),

        CONSTRAINT PK_section PRIMARY KEY (section_id),

        CONSTRAINT FK_section_grade FOREIGN KEY (grade_id) REFERENCES dbo.grade_level(grade_id),

        CONSTRAINT FK_section_period FOREIGN KEY (academic_period_id) REFERENCES dbo.academic_period(academic_period_id),

        CONSTRAINT FK_section_classroom FOREIGN KEY (classroom_id) REFERENCES dbo.classroom(classroom_id),

        CONSTRAINT CK_section_capacity CHECK (capacity > 0)

  );

END;

GO



/* 10. student_guardian: relacion muchos a muchos estudiante-apoderado (transaccional) */

IF OBJECT_ID(N'dbo.student_guardian', N'U') IS NULL

BEGIN

    CREATE TABLE dbo.student_guardian (

        student_id INT NOT NULL,

        guardian_id INT NOT NULL,

        relationship NVARCHAR(50) NOT NULL,

        is_primary BIT NOT NULL CONSTRAINT DF_student_guardian_primary DEFAULT (0),

        CONSTRAINT PK_student_guardian PRIMARY KEY (student_id, guardian_id),

        CONSTRAINT FK_student_guardian_student FOREIGN KEY (student_id) REFERENCES dbo.student(student_id),

        CONSTRAINT FK_student_guardian_guardian FOREIGN KEY (guardian_id) REFERENCES dbo.guardian(guardian_id)

  );

END;

GO



/* 11. enrollment: matriculas */

IF OBJECT_ID(N'dbo.enrollment', N'U') IS NULL

BEGIN

    CREATE TABLE dbo.enrollment (

        enrollment_id INT IDENTITY(1,1) NOT NULL,

        student_id INT NOT NULL,

        section_id BIGINT NOT NULL,

        enrollment_date DATE NOT NULL CONSTRAINT DF_enrollment_date DEFAULT (CONVERT(DATE, GETDATE())),

        status VARCHAR(15) NOT NULL CONSTRAINT DF_enrollment_status DEFAULT ('ACTIVO'),

        created_at DATETIME2 NOT NULL CONSTRAINT DF_enrollment_created DEFAULT (SYSDATETIME()),

        updated_at DATETIME2 NULL,

        CONSTRAINT PK_enrollment PRIMARY KEY (enrollment_id),

        CONSTRAINT FK_enrollment_student FOREIGN KEY (student_id) REFERENCES dbo.student(student_id),

        CONSTRAINT FK_enrollment_section FOREIGN KEY (section_id) REFERENCES dbo.section(section_id)

  );

END;

GO



/* 12. section_course: curso asignado a una seccion y docente */

IF OBJECT_ID(N'dbo.section_course', N'U') IS NULL

BEGIN

    CREATE TABLE dbo.section_course (

        section_course_id INT IDENTITY(1,1) NOT NULL,

        section_id BIGINT NOT NULL,

        course_id INT NOT NULL,

        teacher_id INT NOT NULL,

        status VARCHAR(15) NOT NULL CONSTRAINT DF_section_course_status DEFAULT ('ACTIVO'),

        created_at DATETIME2 NOT NULL CONSTRAINT DF_section_course_created DEFAULT (SYSDATETIME()),

        updated_at DATETIME2 NULL,

        CONSTRAINT PK_section_course PRIMARY KEY (section_course_id),

        CONSTRAINT FK_section_course_section FOREIGN KEY (section_id) REFERENCES dbo.section(section_id),

        CONSTRAINT FK_section_course_course FOREIGN KEY (course_id) REFERENCES dbo.course(course_id),

        CONSTRAINT FK_section_course_teacher FOREIGN KEY (teacher_id) REFERENCES dbo.teacher(teacher_id),

        CONSTRAINT UQ_section_course UNIQUE (section_id, course_id)

  );

END;

GO



/* 13. assessment: evaluaciones */

IF OBJECT_ID(N'dbo.assessment', N'U') IS NULL

BEGIN

    CREATE TABLE dbo.assessment (

        assessment_id INT IDENTITY(1,1) NOT NULL,

        section_course_id INT NOT NULL,

        competency_id INT NOT NULL,

        assessment_name NVARCHAR(150) NOT NULL,

        assessment_date DATE NOT NULL,

        maximum_score DECIMAL(5,2) NOT NULL,

        status VARCHAR(15) NOT NULL CONSTRAINT DF_assessment_status DEFAULT ('PROGRAMADA'),

        created_at DATETIME2 NOT NULL CONSTRAINT DF_assessment_created DEFAULT (SYSDATETIME()),

        updated_at DATETIME2 NULL,

        CONSTRAINT PK_assessment PRIMARY KEY (assessment_id),

        CONSTRAINT FK_assessment_section_course FOREIGN KEY (section_course_id) REFERENCES dbo.section_course(section_course_id),

        CONSTRAINT FK_assessment_competency FOREIGN KEY (competency_id) REFERENCES dbo.competency(competency_id),

        CONSTRAINT CK_assessment_maximum_score CHECK (maximum_score > 0)

  );

END;

GO



/* 14. grade_record: notas */

IF OBJECT_ID(N'dbo.grade_record', N'U') IS NULL

BEGIN

    CREATE TABLE dbo.grade_record (

        grade_record_id INT IDENTITY(1,1) NOT NULL,

        assessment_id INT NOT NULL,

        enrollment_id INT NOT NULL,

        score DECIMAL(5,2) NOT NULL,

        observation NVARCHAR(500) NULL,

        recorded_at DATETIME2 NOT NULL CONSTRAINT DF_grade_record_recorded DEFAULT (SYSDATETIME()),

        updated_at DATETIME2 NULL,

        CONSTRAINT PK_grade_record PRIMARY KEY (grade_record_id),

        CONSTRAINT FK_grade_record_assessment FOREIGN KEY (assessment_id) REFERENCES dbo.assessment(assessment_id),

        CONSTRAINT FK_grade_record_enrollment FOREIGN KEY (enrollment_id) REFERENCES dbo.enrollment(enrollment_id),

        CONSTRAINT UQ_grade_record_assessment_enrollment UNIQUE (assessment_id, enrollment_id),

        CONSTRAINT CK_grade_record_score CHECK (score >= 0)

  );

END;

GO



/* 15. attendance: asistencia */

IF OBJECT_ID(N'dbo.attendance', N'U') IS NULL

BEGIN

    CREATE TABLE dbo.attendance (

        attendance_id BIGINT IDENTITY(1,1) NOT NULL,

        enrollment_id INT NOT NULL,

        section_course_id INT NOT NULL,

        attendance_date DATE NOT NULL,

        attendance_status VARCHAR(15) NOT NULL,

        observation NVARCHAR(500) NULL,

        registered_at DATETIME2 NOT NULL CONSTRAINT DF_attendance_registered DEFAULT (SYSDATETIME()),

        updated_at DATETIME2 NULL,

        CONSTRAINT PK_attendance PRIMARY KEY (attendance_id),

        CONSTRAINT FK_attendance_enrollment FOREIGN KEY (enrollment_id) REFERENCES dbo.enrollment(enrollment_id),

        CONSTRAINT FK_attendance_section_course FOREIGN KEY (section_course_id) REFERENCES dbo.section_course(section_course_id),

        CONSTRAINT CK_attendance_status CHECK (attendance_status IN ('PRESENTE','AUSENTE','TARDANZA','JUSTIFICADO')),

        CONSTRAINT UQ_attendance_daily UNIQUE (enrollment_id, section_course_id, attendance_date)

  );

END;

GO



/* ================================================================

   3. INDICES ADICIONALES

   ================================================================ */



/* Indice filtrado: permite historial de matriculas anuladas, pero solo

   una matricula ACTIVO por estudiante y seccion. */

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'UX_enrollment_student_section_active' AND object_id = OBJECT_ID(N'dbo.enrollment'))

BEGIN

    CREATE UNIQUE INDEX UX_enrollment_student_section_active

    ON dbo.enrollment(student_id, section_id)

    WHERE status = 'ACTIVO';

END;

GO



IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IX_enrollment_section_status' AND object_id = OBJECT_ID(N'dbo.enrollment'))

BEGIN

    CREATE INDEX IX_enrollment_section_status

    ON dbo.enrollment(section_id, status)

    INCLUDE (student_id, enrollment_date);

END;

GO



IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IX_grade_record_enrollment_assessment' AND object_id = OBJECT_ID(N'dbo.grade_record'))

BEGIN

    CREATE INDEX IX_grade_record_enrollment_assessment

    ON dbo.grade_record(enrollment_id, assessment_id)

    INCLUDE (score, recorded_at);

END;

GO



IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IX_attendance_enrollment_date' AND object_id = OBJECT_ID(N'dbo.attendance'))

BEGIN

    CREATE INDEX IX_attendance_enrollment_date

    ON dbo.attendance(enrollment_id, attendance_date)

    INCLUDE (attendance_status, section_course_id);

END;

GO



IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'UX_student_guardian_primary' AND object_id = OBJECT_ID(N'dbo.student_guardian'))

BEGIN

    CREATE UNIQUE INDEX UX_student_guardian_primary

    ON dbo.student_guardian(student_id)

    WHERE is_primary = 1;

END;

GO



/* ================================================================

   4. TRIGGERS: VALIDAR NOTAS AL INSERTAR Y ACTUALIZAR

   ================================================================ */

CREATE OR ALTER TRIGGER dbo.trg_grade_record_after_insert

ON dbo.grade_record

AFTER INSERT

AS

BEGIN

    SET NOCOUNT ON;



    IF EXISTS (

        SELECT 1

        FROM inserted AS i

        INNER JOIN dbo.assessment AS a ON a.assessment_id = i.assessment_id

        WHERE i.score < 0 OR i.score > a.maximum_score

  )

    BEGIN

        THROW 50001, 'La nota debe estar entre cero y la puntuacion maxima de la evaluacion.', 1;

    END;

END;

GO



CREATE OR ALTER TRIGGER dbo.trg_grade_record_after_update

ON dbo.grade_record

AFTER UPDATE

AS

BEGIN

    SET NOCOUNT ON;



    IF EXISTS (

        SELECT 1

        FROM inserted AS i

        INNER JOIN dbo.assessment AS a ON a.assessment_id = i.assessment_id

        WHERE i.score < 0 OR i.score > a.maximum_score

  )

    BEGIN

        THROW 50002, 'Actualizacion rechazada: la nota supera la puntuacion maxima permitida.', 1;

    END;

END;

GO



/* ================================================================

   5. VISTAS

   ================================================================ */

CREATE OR ALTER VIEW dbo.vw_student_enrollments

AS

SELECT

    s.student_id,

    s.document_number,

    s.first_name,

    s.last_name,

    e.enrollment_id,

    e.enrollment_date,

    e.status AS enrollment_status,

    sec.section_name,

    gl.grade_name,

    ap.period_name,

    ap.academic_year

FROM dbo.student AS s

INNER JOIN dbo.enrollment AS e ON e.student_id = s.student_id

INNER JOIN dbo.section AS sec ON sec.section_id = e.section_id

INNER JOIN dbo.grade_level AS gl ON gl.grade_id = sec.grade_id

INNER JOIN dbo.academic_period AS ap ON ap.academic_period_id = sec.academic_period_id;

GO



CREATE OR ALTER VIEW dbo.vw_student_grades

AS

SELECT

    s.student_id,

    s.first_name,

    s.last_name,

    c.course_name,

    a.assessment_name,

    a.assessment_date,

    a.maximum_score,

    gr.score,

    gr.observation

FROM dbo.grade_record AS gr

INNER JOIN dbo.assessment AS a ON a.assessment_id = gr.assessment_id

INNER JOIN dbo.enrollment AS e ON e.enrollment_id = gr.enrollment_id

INNER JOIN dbo.student AS s ON s.student_id = e.student_id

INNER JOIN dbo.section_course AS sc ON sc.section_course_id = a.section_course_id

INNER JOIN dbo.course AS c ON c.course_id = sc.course_id;

GO



CREATE OR ALTER VIEW dbo.vw_student_attendance

AS

SELECT

    s.student_id,

    s.first_name,

    s.last_name,

    c.course_name,

    att.attendance_date,

    att.attendance_status,

    att.observation

FROM dbo.attendance AS att

INNER JOIN dbo.enrollment AS e ON e.enrollment_id = att.enrollment_id

INNER JOIN dbo.student AS s ON s.student_id = e.student_id

INNER JOIN dbo.section_course AS sc ON sc.section_course_id = att.section_course_id

INNER JOIN dbo.course AS c ON c.course_id = sc.course_id;

GO



/* ================================================================

   6. DATOS DE PRUEBA

   Se insertan solo si las tablas correspondientes estan vacias.

   ================================================================ */



IF NOT EXISTS (SELECT 1 FROM dbo.academic_period)

BEGIN

    INSERT INTO dbo.academic_period (period_name, academic_year, start_date, end_date)

    VALUES (N'Primer periodo', 2026, '2026-03-01', '2026-07-31');

END;

GO



IF NOT EXISTS (SELECT 1 FROM dbo.grade_level)

BEGIN

    INSERT INTO dbo.grade_level (grade_name, education_level, grade_order)

    VALUES (N'Primero de secundaria', N'Secundaria', 1),

           (N'Segundo de secundaria', N'Secundaria', 2);

END;

GO



IF NOT EXISTS (SELECT 1 FROM dbo.classroom)

BEGIN

    INSERT INTO dbo.classroom (code, classroom_name, capacity)

    VALUES ('A-101', N'Aula 101', 30),

           ('A-102', N'Aula 102', 30);

END;

GO



IF NOT EXISTS (SELECT 1 FROM dbo.student)

BEGIN

    INSERT INTO dbo.student (student_id, document_type, document_number, first_name, last_name, birth_date, gender)

    VALUES (1001, 'DNI', '70000001', N'Ana', N'Gomez', '2012-05-10', 'F'),

           (1002, 'DNI', '70000002', N'Luis', N'Ramirez', '2012-08-15', 'M'),

           (1003, 'DNI', '70000003', N'Maria', N'Torres', '2011-11-20', 'F');

END;

GO



IF NOT EXISTS (SELECT 1 FROM dbo.guardian)

BEGIN

    INSERT INTO dbo.guardian (document_type, document_number, first_name, last_name, phone, email)

    VALUES ('DNI', '40000001', N'Carlos', N'Gomez', '999111222', N'carlos@example.com'),

           ('DNI', '40000002', N'Rosa', N'Ramirez', '999333444', N'rosa@example.com');

END;

GO



IF NOT EXISTS (SELECT 1 FROM dbo.teacher)

BEGIN

    INSERT INTO dbo.teacher (document_type, document_number, first_name, last_name, specialty, education_level, phone, email, hire_date)

    VALUES ('DNI', '50000001', N'Pedro', N'Lopez', N'Matematica', N'Licenciado', '988111222', N'pedro@example.com', '2020-03-01'),

           ('DNI', '50000002', N'Lucia', N'Perez', N'Comunicacion', N'Licenciada', '988333444', N'lucia@example.com', '2021-03-01');

END;

GO



IF NOT EXISTS (SELECT 1 FROM dbo.course)

BEGIN

    INSERT INTO dbo.course (course_name, description)

    VALUES (N'Matematica', N'Razonamiento matematico y resolucion de problemas'),

           (N'Comunicacion', N'Comprension lectora y expresion escrita');

END;

GO



IF NOT EXISTS (SELECT 1 FROM dbo.competency)

BEGIN

    INSERT INTO dbo.competency (course_id, competency_name, description)

    SELECT c.course_id, v.competency_name, v.description

    FROM dbo.course AS c

    INNER JOIN (VALUES

        (N'Matematica', N'Resuelve problemas de cantidad', N'Usa estrategias de calculo'),

        (N'Comunicacion', N'Lee diversos tipos de textos', N'Interpreta textos escritos')

  ) AS v(course_name, competency_name, description) ON v.course_name = c.course_name;

END;

GO



IF NOT EXISTS (SELECT 1 FROM dbo.section)

BEGIN

    INSERT INTO dbo.section (section_name, grade_id, academic_period_id, classroom_id, shift, capacity)

    SELECT N'A', gl.grade_id, ap.academic_period_id, cl.classroom_id, 'MANANA', 30

    FROM dbo.grade_level AS gl

    CROSS JOIN dbo.academic_period AS ap

    CROSS JOIN dbo.classroom AS cl

    WHERE gl.grade_order = 1 AND cl.code = 'A-101'

      AND ap.academic_year = 2026;

END;

GO



IF NOT EXISTS (SELECT 1 FROM dbo.student_guardian)

BEGIN

    INSERT INTO dbo.student_guardian (student_id, guardian_id, relationship, is_primary)

    SELECT 1001, guardian_id, N'Padre', 1 FROM dbo.guardian WHERE document_number = '40000001'

    UNION ALL

    SELECT 1002, guardian_id, N'Madre', 1 FROM dbo.guardian WHERE document_number = '40000002';

END;

GO



IF NOT EXISTS (SELECT 1 FROM dbo.enrollment)

BEGIN

    INSERT INTO dbo.enrollment (student_id, section_id, enrollment_date, status)

    SELECT s.student_id, sec.section_id, '2026-03-02', 'ACTIVO'

    FROM dbo.student AS s

    CROSS JOIN dbo.section AS sec

    WHERE s.student_id IN (1001, 1002) AND sec.section_name = N'A';

END;

GO



IF NOT EXISTS (SELECT 1 FROM dbo.section_course)

BEGIN

    INSERT INTO dbo.section_course (section_id, course_id, teacher_id)

    SELECT sec.section_id, c.course_id, t.teacher_id

    FROM dbo.section AS sec

    CROSS JOIN dbo.course AS c

    CROSS JOIN dbo.teacher AS t

    WHERE sec.section_name = N'A'

      AND ((c.course_name = N'Matematica' AND t.document_number = '50000001')

        OR (c.course_name = N'Comunicacion' AND t.document_number = '50000002'));

END;

GO



IF NOT EXISTS (SELECT 1 FROM dbo.assessment)

BEGIN

    INSERT INTO dbo.assessment (section_course_id, competency_id, assessment_name, assessment_date, maximum_score, status)

    SELECT sc.section_course_id, cp.competency_id, N'Evaluacion 1', '2026-04-15', 20, 'APLICADA'

    FROM dbo.section_course AS sc

    INNER JOIN dbo.course AS c ON c.course_id = sc.course_id

    INNER JOIN dbo.competency AS cp ON cp.course_id = c.course_id

    WHERE c.course_name = N'Matematica';

END;

GO



IF NOT EXISTS (SELECT 1 FROM dbo.grade_record)

BEGIN

    INSERT INTO dbo.grade_record (assessment_id, enrollment_id, score, observation)

    SELECT a.assessment_id, e.enrollment_id, v.score, v.observation

    FROM dbo.assessment AS a

    CROSS JOIN (VALUES (1001, CONVERT(DECIMAL(5,2), 18), N'Buen trabajo'),

                       (1002, CONVERT(DECIMAL(5,2), 16), N'Puede mejorar')) AS v(student_id, score, observation)

    INNER JOIN dbo.enrollment AS e ON e.student_id = v.student_id

    WHERE a.assessment_name = N'Evaluacion 1';

END;

GO



IF NOT EXISTS (SELECT 1 FROM dbo.attendance)

BEGIN

    INSERT INTO dbo.attendance (enrollment_id, section_course_id, attendance_date, attendance_status, observation)

    SELECT e.enrollment_id, sc.section_course_id, '2026-04-16',

           CASE WHEN e.student_id = 1001 THEN 'PRESENTE' ELSE 'TARDANZA' END,

           N'Registro de prueba'

    FROM dbo.enrollment AS e

    INNER JOIN dbo.section AS sec ON sec.section_id = e.section_id

    INNER JOIN dbo.section_course AS sc ON sc.section_id = sec.section_id

    INNER JOIN dbo.course AS c ON c.course_id = sc.course_id

    WHERE e.student_id IN (1001, 1002) AND c.course_name = N'Matematica';

END;

GO



/* ================================================================
   6.1 PRUEBAS DE FUNCIONAMIENTO DE TRIGGERS
   Ejecutar después de crear tablas, triggers y datos de prueba.
   Las transacciones se revierten; no quedan notas incorrectas guardadas.
================================================================ */


/* ================================================================
   6.1 PRUEBAS DE FUNCIONAMIENTO DE TRIGGERS
================================================================ */

GO

/* PRUEBA AFTER INSERT */

CREATE OR ALTER PROCEDURE dbo.usp_test_trigger_after_insert
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE
        @section_course_id INT,
        @competency_id INT,
        @enrollment_id INT,
        @assessment_id INT,
        @maximum_score DECIMAL(5,2);

    SELECT TOP (1)
        @section_course_id = a.section_course_id,
        @competency_id = a.competency_id,
        @enrollment_id = e.enrollment_id,
        @maximum_score = a.maximum_score
    FROM dbo.assessment a
    INNER JOIN dbo.section_course sc
        ON sc.section_course_id = a.section_course_id
    INNER JOIN dbo.enrollment e
        ON e.section_id = sc.section_id;

    IF @enrollment_id IS NULL
    BEGIN
        SELECT 'SIN DATOS' AS resultado;
        RETURN;
    END;

    BEGIN TRY
        BEGIN TRANSACTION;

        INSERT INTO dbo.assessment
        (section_course_id, competency_id, assessment_name,
         assessment_date, maximum_score, status)
        VALUES
        (@section_course_id, @competency_id,
         N'PRUEBA TRIGGER INSERT', GETDATE(),
         @maximum_score, 'APLICADA');

        SET @assessment_id = CONVERT(INT, SCOPE_IDENTITY());

        INSERT INTO dbo.grade_record
        (assessment_id, enrollment_id, score, observation)
        VALUES
        (@assessment_id, @enrollment_id,
         @maximum_score + 5, N'Prueba INSERT');

        ROLLBACK TRANSACTION;

        SELECT 'ERROR: TRIGGER NO ACTIVADO' AS resultado;

    END TRY
    BEGIN CATCH
        IF XACT_STATE() <> 0
            ROLLBACK TRANSACTION;

        IF ERROR_NUMBER() = 50001
            SELECT
                'PRUEBA EXITOSA - AFTER INSERT' AS resultado,
                ERROR_MESSAGE() AS detalle;
        ELSE
            SELECT
                'ERROR INSERT' AS resultado,
                ERROR_NUMBER() AS numero_error,
                ERROR_MESSAGE() AS detalle;
    END CATCH;
END;

GO

/* PRUEBA AFTER UPDATE */

CREATE OR ALTER PROCEDURE dbo.usp_test_trigger_after_update
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE
        @grade_record_id INT,
        @maximum_score DECIMAL(5,2);

    SELECT TOP (1)
        @grade_record_id = gr.grade_record_id,
        @maximum_score = a.maximum_score
    FROM dbo.grade_record gr
    INNER JOIN dbo.assessment a
        ON a.assessment_id = gr.assessment_id;

    IF @grade_record_id IS NULL
    BEGIN
        SELECT 'SIN DATOS' AS resultado;
        RETURN;
    END;

    BEGIN TRY
        BEGIN TRANSACTION;

        UPDATE dbo.grade_record
        SET score = @maximum_score + 5
        WHERE grade_record_id = @grade_record_id;

        ROLLBACK TRANSACTION;

        SELECT 'ERROR: TRIGGER NO ACTIVADO' AS resultado;

    END TRY
    BEGIN CATCH
        IF XACT_STATE() <> 0
            ROLLBACK TRANSACTION;

        IF ERROR_NUMBER() = 50002
            SELECT
                'PRUEBA EXITOSA - AFTER UPDATE' AS resultado,
                ERROR_MESSAGE() AS detalle;
        ELSE
            SELECT
                'ERROR UPDATE' AS resultado,
                ERROR_NUMBER() AS numero_error,
                ERROR_MESSAGE() AS detalle;
    END CATCH;
END;

GO

/* EJECUTAR LAS DOS PRUEBAS */

EXEC dbo.usp_test_trigger_after_insert;
GO

EXEC dbo.usp_test_trigger_after_update;
GO


/* ================================================================

   7. CONSULTAS COMPLEJAS: INNER / LEFT / RIGHT / FULL OUTER JOIN

   ================================================================ */



/* Consulta 1 - INNER JOIN:

   Estudiantes matriculados, seccion, grado y periodo academico. */

SELECT

    s.student_id,

    s.first_name,

    s.last_name,

    e.enrollment_id,

    sec.section_name,

    gl.grade_name,

    ap.period_name,

    e.enrollment_date

FROM dbo.student AS s

INNER JOIN dbo.enrollment AS e ON e.student_id = s.student_id

INNER JOIN dbo.section AS sec ON sec.section_id = e.section_id

INNER JOIN dbo.grade_level AS gl ON gl.grade_id = sec.grade_id

INNER JOIN dbo.academic_period AS ap ON ap.academic_period_id = sec.academic_period_id;

GO



/* Consulta 2 - LEFT JOIN:

   Todos los estudiantes, incluso los que no tienen matricula. */

SELECT

    s.student_id,

    s.first_name,

    s.last_name,

    e.enrollment_id,

    e.status AS enrollment_status

FROM dbo.student AS s

LEFT JOIN dbo.enrollment AS e ON e.student_id = s.student_id

ORDER BY s.student_id;

GO



/* Consulta 3 - RIGHT JOIN:

   Todos los cursos, aunque no tengan una asignacion a seccion/docente. */

SELECT

    c.course_id,

    c.course_name,

    sc.section_course_id,

    t.first_name AS teacher_first_name,

    t.last_name AS teacher_last_name

FROM dbo.teacher AS t

RIGHT JOIN dbo.section_course AS sc ON sc.teacher_id = t.teacher_id

RIGHT JOIN dbo.course AS c ON c.course_id = sc.course_id

ORDER BY c.course_id;

GO



/* Consulta 4 - FULL OUTER JOIN:

   Todos los estudiantes y todos los apoderados, tengan o no relacion. */

SELECT

    s.student_id,

    s.first_name AS student_first_name,

    s.last_name AS student_last_name,

    sg.relationship,

    g.guardian_id,

    g.first_name AS guardian_first_name,

    g.last_name AS guardian_last_name

FROM dbo.student AS s

FULL OUTER JOIN dbo.student_guardian AS sg ON sg.student_id = s.student_id

FULL OUTER JOIN dbo.guardian AS g ON g.guardian_id = sg.guardian_id

ORDER BY s.student_id, g.guardian_id;

GO



/* Consulta adicional: notas por estudiante y curso. */

SELECT *

FROM dbo.vw_student_grades

ORDER BY student_id, course_name;

GO
/* ================================================================

   8. CONSULTAS PARA VER TODAS LAS TABLAS Y SU ESTRUCTURA

   ================================================================ */



-- 8.1 Ver las 15 tablas de la base actual.

SELECT TABLE_SCHEMA AS esquema, TABLE_NAME AS tabla

FROM INFORMATION_SCHEMA.TABLES

WHERE TABLE_TYPE = 'BASE TABLE'

ORDER BY TABLE_NAME;

GO



-- 8.2 Ver columnas, tipos de datos y nulabilidad.

SELECT

    TABLE_NAME AS tabla,

    ORDINAL_POSITION AS orden_columna,

    COLUMN_NAME AS columna,

    DATA_TYPE AS tipo_dato,

    CHARACTER_MAXIMUM_LENGTH AS longitud,

    IS_NULLABLE AS permite_nulos

FROM INFORMATION_SCHEMA.COLUMNS

ORDER BY TABLE_NAME, ORDINAL_POSITION;

GO



-- 8.3 Ver claves primarias.

SELECT

    tc.TABLE_NAME AS tabla,

    tc.CONSTRAINT_NAME AS clave_primaria,

    kcu.COLUMN_NAME AS columna

FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS AS tc

INNER JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE AS kcu

    ON kcu.CONSTRAINT_NAME = tc.CONSTRAINT_NAME

   AND kcu.TABLE_SCHEMA = tc.TABLE_SCHEMA

WHERE tc.CONSTRAINT_TYPE = 'PRIMARY KEY'

ORDER BY tc.TABLE_NAME, kcu.ORDINAL_POSITION;

GO



-- 8.4 Ver claves foraneas y las columnas relacionadas.

SELECT

    fk.name AS nombre_fk,

    OBJECT_SCHEMA_NAME(fk.parent_object_id) AS esquema_origen,

    OBJECT_NAME(fk.parent_object_id) AS tabla_origen,

    pc.name AS columna_origen,

    OBJECT_SCHEMA_NAME(fk.referenced_object_id) AS esquema_destino,

    OBJECT_NAME(fk.referenced_object_id) AS tabla_destino,

    rc.name AS columna_destino

FROM sys.foreign_keys AS fk

INNER JOIN sys.foreign_key_columns AS fkc ON fkc.constraint_object_id = fk.object_id

INNER JOIN sys.columns AS pc ON pc.object_id = fkc.parent_object_id AND pc.column_id = fkc.parent_column_id

INNER JOIN sys.columns AS rc ON rc.object_id = fkc.referenced_object_id AND rc.column_id = fkc.referenced_column_id

ORDER BY tabla_origen, nombre_fk;

GO



-- 8.5 Ver indices.

SELECT

    OBJECT_NAME(i.object_id) AS tabla,

    i.name AS indice,

    i.type_desc AS tipo_indice,

    i.is_unique AS es_unico

FROM sys.indexes AS i

WHERE i.object_id IN (SELECT object_id FROM sys.tables)

  AND i.name IS NOT NULL

ORDER BY tabla, indice;

GO



-- 8.6 Ver vistas.

SELECT TABLE_SCHEMA AS esquema, TABLE_NAME AS vista

FROM INFORMATION_SCHEMA.VIEWS

ORDER BY TABLE_NAME;

GO



-- 8.7 Ver triggers.

SELECT

    tr.name AS trigger_name,

    OBJECT_SCHEMA_NAME(tr.parent_id) AS esquema,

    OBJECT_NAME(tr.parent_id) AS tabla,

    tr.is_disabled AS esta_deshabilitado

FROM sys.triggers AS tr

WHERE tr.is_ms_shipped = 0

ORDER BY tr.name;

GO



/* ================================================================

   9. PRUEBA DE INDICES Y PLAN DE EJECUCION

   ================================================================

   En DBeaver, activa el plan de ejecucion (Explain Execution Plan)

   antes de ejecutar estas consultas. Tambien puedes activar:

   SET STATISTICS IO ON; SET STATISTICS TIME ON;

   Compara el plan y las lecturas logicas con y sin los indices

   IX_enrollment_section_status, IX_grade_record_enrollment_assessment

   e IX_attendance_enrollment_date.

   ================================================================ */

SET STATISTICS IO ON;

SET STATISTICS TIME ON;

GO



SELECT student_id, enrollment_date

FROM dbo.enrollment

WHERE section_id = 1 AND status = 'ACTIVO';

GO



SELECT assessment_id, score, recorded_at

FROM dbo.grade_record

WHERE enrollment_id = 1;

GO



SELECT attendance_date, attendance_status, section_course_id

FROM dbo.attendance

WHERE enrollment_id = 1

  AND attendance_date >= '2026-01-01'

  AND attendance_date < '2027-01-01';

GO



SET STATISTICS IO OFF;

SET STATISTICS TIME OFF;

GO





/* ================================================================

   10. MOSTRAR RESULTADOS DE LAS VISTAS

   ================================================================ */

SELECT * FROM dbo.vw_student_enrollments;

GO

SELECT * FROM dbo.vw_student_grades;

GO

SELECT * FROM dbo.vw_student_attendance;

GO



/* ================================================================
   12. FORMULARIO DE CONTACTO
   Guarda los mensajes enviados desde la pagina publica de contacto.
   Este bloque es idempotente: si la tabla ya existe, no la elimina.
   ================================================================ */

IF OBJECT_ID(N'dbo.contact_message', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.contact_message (
        contact_id INT IDENTITY(1,1) NOT NULL,
        full_name NVARCHAR(150) NOT NULL,
        email NVARCHAR(254) NOT NULL,
        subject NVARCHAR(500) NULL,
        message NVARCHAR(MAX) NOT NULL,
        status VARCHAR(20) NOT NULL
            CONSTRAINT DF_contact_message_status DEFAULT ('PENDIENTE'),
        created_at DATETIME2(0) NOT NULL
            CONSTRAINT DF_contact_message_created DEFAULT (SYSDATETIME()),
        updated_at DATETIME2(0) NULL,
        CONSTRAINT PK_contact_message PRIMARY KEY (contact_id),
        CONSTRAINT CK_contact_message_name
            CHECK (LEN(LTRIM(RTRIM(full_name))) > 0),
        CONSTRAINT CK_contact_message_email
            CHECK (
                LEN(LTRIM(RTRIM(email))) > 3
                AND email LIKE '%_@_%.__%'
                AND (LOWER(RIGHT(RTRIM(email), 4)) = '.com'
                     OR LOWER(RIGHT(RTRIM(email), 7)) = '.edu.pe')
            ),
        CONSTRAINT CK_contact_message_content
            CHECK (LEN(LTRIM(RTRIM(message))) > 0),
        CONSTRAINT CK_contact_message_status
            CHECK (status IN ('PENDIENTE', 'EN_REVISION', 'RESPONDIDO', 'CERRADO'))
    );
END;
GO

IF NOT EXISTS (
    SELECT 1 FROM sys.indexes
    WHERE name = N'IX_contact_message_status_created'
      AND object_id = OBJECT_ID(N'dbo.contact_message')
)
BEGIN
    CREATE INDEX IX_contact_message_status_created
        ON dbo.contact_message(status, created_at DESC);
END;
GO

/* Consulta de verificacion de los mensajes recibidos.
   No inserta mensajes de prueba ni modifica los existentes. */
SELECT
    contact_id,
    full_name,
    email,
    subject,
    status,
    created_at,
    updated_at
FROM dbo.contact_message
ORDER BY created_at DESC;
GO

PRINT 'Tabla dbo.contact_message verificada.';
GO

/* ================================================================

   11. VERIFICACION DE LA BASE DE DATOS

   ================================================================ */

-- Verificar las tablas.
SELECT
    TABLE_NAME AS NombreTabla
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE'
ORDER BY TABLE_NAME;

-- Verificar las columnas.
SELECT
    TABLE_NAME AS NombreTabla,
    COLUMN_NAME AS NombreColumna,
    DATA_TYPE AS TipoDato
FROM INFORMATION_SCHEMA.COLUMNS
ORDER BY TABLE_NAME, ORDINAL_POSITION;

-- Verificar las relaciones.
SELECT
    name AS NombreRelacion,
    OBJECT_NAME(parent_object_id) AS TablaOrigen,
    OBJECT_NAME(referenced_object_id) AS TablaDestino
FROM sys.foreign_keys;

-- Verificar los índices.
SELECT
    OBJECT_NAME(object_id) AS NombreTabla,
    name AS NombreIndice
FROM sys.indexes
WHERE name IS NOT NULL
ORDER BY NombreTabla;

-- Verificar las vistas.
SELECT name AS NombreVista
FROM sys.views;

-- Verificar los triggers.
SELECT
    name AS NombreTrigger,
    OBJECT_NAME(parent_id) AS Tabla
FROM sys.triggers
WHERE is_ms_shipped = 0;


/* FIN DEL SCRIPT */

PRINT 'Script de GestionAcademica ejecutado. Revisa los resultados y mensajes anteriores.';

GO

/* Ver los registros de las tablas */
SELECT * FROM contact_message;



SELECT name FROM sys.databases;

