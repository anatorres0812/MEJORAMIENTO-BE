/*
===============================================================================
SISTEMA DE GESTIÓN ACADÉMICA - TORRESANA
Motor: Microsoft SQL Server 2022
Base de datos: BD_Gestion_Academica_v2
Versión: 1.0
===============================================================================
OBJETIVOS
- Crear la base de datos y las tablas de gestión académica.
- Corregir tipos de datos evidentemente inadecuados (fechas, notas y auditoría).
- Incorporar claves primarias, foráneas, restricciones CHECK y UNIQUE.
- Incorporar auditoría básica: created_at, updated_at, created_by, updated_by.
- Crear audit_log para registrar operaciones.
- Crear índices para relaciones y consultas frecuentes.
- Ser re-ejecutable: no elimina tablas ni datos existentes.

IMPORTANTE
1. Ejecutar primero en una base de datos de desarrollo/pruebas.
2. Este script NO elimina tablas ni datos.
3. Las tablas Copy_of_* se conservan por compatibilidad con el esquema proporcionado.
4. Las fechas se guardan como DATE; las notas como DECIMAL(4,2), de 0 a 20.
5. Auditoría automática de cambios: updated_at se actualiza mediante triggers.
6. Las columnas de auditoría no sustituyen un sistema de permisos ni una auditoría
   de seguridad completa.
===============================================================================
*/

USE master;
GO

IF DB_ID(N'BD_Gestion_Academica_v2') IS NULL
BEGIN
    CREATE DATABASE BD_Gestion_Academica_v2;
END;
GO

USE BD_Gestion_Academica_v2;
GO

SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
SET XACT_ABORT ON;
GO

/* ============================================================================
   00. TABLA DE AUDITORÍA
   Registra eventos de INSERT, UPDATE y DELETE realizados sobre tablas auditadas.
   El usuario de aplicación puede guardarse en SESSION_CONTEXT('app_user').
   ============================================================================ */
IF OBJECT_ID(N'dbo.audit_log', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.audit_log (
        audit_log_id BIGINT IDENTITY(1,1) NOT NULL
            CONSTRAINT PK_audit_log PRIMARY KEY,
        table_name SYSNAME NOT NULL,
        operation_type VARCHAR(10) NOT NULL,
        record_key NVARCHAR(200) NULL,
        changed_at DATETIME2(3) NOT NULL
            CONSTRAINT DF_audit_log_changed_at DEFAULT SYSUTCDATETIME(),
        changed_by NVARCHAR(128) NOT NULL
            CONSTRAINT DF_audit_log_changed_by DEFAULT
                (COALESCE(CONVERT(NVARCHAR(128), SESSION_CONTEXT(N'app_user')), ORIGINAL_LOGIN())),
        details NVARCHAR(MAX) NULL,
        CONSTRAINT CK_audit_log_operation
            CHECK (operation_type IN ('INSERT','UPDATE','DELETE'))
    );
END;
GO

/* ============================================================================
   01. GRADE - Grados académicos
   ============================================================================ */
IF OBJECT_ID(N'dbo.grade', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.grade (
        grade_id BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_grade PRIMARY KEY,
        grade_name NVARCHAR(100) NOT NULL,
        education_level NVARCHAR(15) NOT NULL,
        grade_order INT NOT NULL,
        description NVARCHAR(255) NULL,
        status NVARCHAR(10) NOT NULL CONSTRAINT DF_grade_status DEFAULT N'ACTIVE',
        created_at DATETIME2(3) NOT NULL CONSTRAINT DF_grade_created_at DEFAULT SYSUTCDATETIME(),
        updated_at DATETIME2(3) NOT NULL CONSTRAINT DF_grade_updated_at DEFAULT SYSUTCDATETIME(),
        created_by NVARCHAR(128) NOT NULL CONSTRAINT DF_grade_created_by DEFAULT
            (COALESCE(CONVERT(NVARCHAR(128), SESSION_CONTEXT(N'app_user')), ORIGINAL_LOGIN())),
        updated_by NVARCHAR(128) NOT NULL CONSTRAINT DF_grade_updated_by DEFAULT
            (COALESCE(CONVERT(NVARCHAR(128), SESSION_CONTEXT(N'app_user')), ORIGINAL_LOGIN())),
        CONSTRAINT UQ_grade_name_level UNIQUE (grade_name, education_level),
        CONSTRAINT CK_grade_order CHECK (grade_order > 0),
        CONSTRAINT CK_grade_education_level CHECK (education_level IN (N'INICIAL',N'PRIMARIA',N'SECUNDARIA')),
        CONSTRAINT CK_grade_status CHECK (status IN (N'ACTIVE',N'INACTIVE'))
    );
END;
GO

/* ============================================================================
   02. SECTION - Secciones
   ============================================================================ */
IF OBJECT_ID(N'dbo.section', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.section (
        section_id BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_section PRIMARY KEY,
        section_name NVARCHAR(50) NOT NULL,
        capacity INT NOT NULL,
        shift NVARCHAR(10) NOT NULL,
        status NVARCHAR(10) NOT NULL CONSTRAINT DF_section_status DEFAULT N'ACTIVE',
        created_at DATETIME2(3) NOT NULL CONSTRAINT DF_section_created_at DEFAULT SYSUTCDATETIME(),
        updated_at DATETIME2(3) NOT NULL CONSTRAINT DF_section_updated_at DEFAULT SYSUTCDATETIME(),
        created_by NVARCHAR(128) NOT NULL CONSTRAINT DF_section_created_by DEFAULT
            (COALESCE(CONVERT(NVARCHAR(128), SESSION_CONTEXT(N'app_user')), ORIGINAL_LOGIN())),
        updated_by NVARCHAR(128) NOT NULL CONSTRAINT DF_section_updated_by DEFAULT
            (COALESCE(CONVERT(NVARCHAR(128), SESSION_CONTEXT(N'app_user')), ORIGINAL_LOGIN())),
        CONSTRAINT UQ_section_name_shift UNIQUE (section_name, shift),
        CONSTRAINT CK_section_capacity CHECK (capacity > 0),
        CONSTRAINT CK_section_shift CHECK (shift IN (N'MAÑANA',N'TARDE',N'NOCHE',N'COMPLETO')),
        CONSTRAINT CK_section_status CHECK (status IN (N'ACTIVE',N'INACTIVE'))
    );
END;
GO

/* ============================================================================
   03. TEACHER - Docentes
   ============================================================================ */
IF OBJECT_ID(N'dbo.teacher', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.teacher (
        teacher_id INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_teacher PRIMARY KEY,
        document_type NVARCHAR(10) NOT NULL,
        document_number NVARCHAR(20) NOT NULL,
        first_name NVARCHAR(100) NOT NULL,
        last_name NVARCHAR(100) NOT NULL,
        specialty NVARCHAR(150) NULL,
        education_level NVARCHAR(15) NULL,
        phone NVARCHAR(15) NULL,
        email NVARCHAR(150) NULL,
        hire_date DATE NULL,
        status NVARCHAR(10) NOT NULL CONSTRAINT DF_teacher_status DEFAULT N'ACTIVE',
        created_at DATETIME2(3) NOT NULL CONSTRAINT DF_teacher_created_at DEFAULT SYSUTCDATETIME(),
        updated_at DATETIME2(3) NOT NULL CONSTRAINT DF_teacher_updated_at DEFAULT SYSUTCDATETIME(),
        created_by NVARCHAR(128) NOT NULL CONSTRAINT DF_teacher_created_by DEFAULT
            (COALESCE(CONVERT(NVARCHAR(128), SESSION_CONTEXT(N'app_user')), ORIGINAL_LOGIN())),
        updated_by NVARCHAR(128) NOT NULL CONSTRAINT DF_teacher_updated_by DEFAULT
            (COALESCE(CONVERT(NVARCHAR(128), SESSION_CONTEXT(N'app_user')), ORIGINAL_LOGIN())),
        CONSTRAINT UQ_teacher_document UNIQUE (document_type, document_number),
        CONSTRAINT CK_teacher_document_type CHECK (document_type IN (N'DNI',N'CE',N'PAS',N'OTRO')),
        CONSTRAINT CK_teacher_email CHECK (email IS NULL OR email LIKE N'%_@_%._%'),
        CONSTRAINT CK_teacher_status CHECK (status IN (N'ACTIVE',N'INACTIVE'))
    );
END;
GO

/* ============================================================================
   04. CLASSROOM - Aula/sección asignada por año
   ============================================================================ */
IF OBJECT_ID(N'dbo.classroom', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.classroom (
        classroom_id INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_classroom PRIMARY KEY,
        code NVARCHAR(30) NOT NULL,
        classroom_name NVARCHAR(100) NOT NULL,
        education_level NVARCHAR(15) NOT NULL,
        academic_year SMALLINT NOT NULL,
        grade_id BIGINT NOT NULL,
        section_id BIGINT NOT NULL,
        capacity INT NOT NULL,
        teacher_id INT NULL,
        status NVARCHAR(10) NOT NULL CONSTRAINT DF_classroom_status DEFAULT N'ACTIVE',
        created_at DATETIME2(3) NOT NULL CONSTRAINT DF_classroom_created_at DEFAULT SYSUTCDATETIME(),
        updated_at DATETIME2(3) NOT NULL CONSTRAINT DF_classroom_updated_at DEFAULT SYSUTCDATETIME(),
        created_by NVARCHAR(128) NOT NULL CONSTRAINT DF_classroom_created_by DEFAULT
            (COALESCE(CONVERT(NVARCHAR(128), SESSION_CONTEXT(N'app_user')), ORIGINAL_LOGIN())),
        updated_by NVARCHAR(128) NOT NULL CONSTRAINT DF_classroom_updated_by DEFAULT
            (COALESCE(CONVERT(NVARCHAR(128), SESSION_CONTEXT(N'app_user')), ORIGINAL_LOGIN())),
        CONSTRAINT UQ_classroom_code_year UNIQUE (code, academic_year),
        CONSTRAINT FK_classroom_grade FOREIGN KEY (grade_id) REFERENCES dbo.grade(grade_id),
        CONSTRAINT FK_classroom_section FOREIGN KEY (section_id) REFERENCES dbo.section(section_id),
        CONSTRAINT FK_classroom_teacher FOREIGN KEY (teacher_id) REFERENCES dbo.teacher(teacher_id),
        CONSTRAINT CK_classroom_capacity CHECK (capacity > 0),
        CONSTRAINT CK_classroom_year CHECK (academic_year BETWEEN 2000 AND 2100),
        CONSTRAINT CK_classroom_level CHECK (education_level IN (N'INICIAL',N'PRIMARIA',N'SECUNDARIA')),
        CONSTRAINT CK_classroom_status CHECK (status IN (N'ACTIVE',N'INACTIVE'))
    );
END;
GO

/* ============================================================================
   05. ACADEMIC_PERIOD - Periodos académicos
   ============================================================================ */
IF OBJECT_ID(N'dbo.academic_period', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.academic_period (
        academic_period_id INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_academic_period PRIMARY KEY,
        period_name NVARCHAR(100) NOT NULL,
        academic_year SMALLINT NOT NULL,
        start_date DATE NOT NULL,
        end_date DATE NOT NULL,
        is_active BIT NOT NULL CONSTRAINT DF_academic_period_is_active DEFAULT 1,
        status NVARCHAR(10) NOT NULL CONSTRAINT DF_academic_period_status DEFAULT N'ACTIVE',
        created_at DATETIME2(3) NOT NULL CONSTRAINT DF_academic_period_created_at DEFAULT SYSUTCDATETIME(),
        updated_at DATETIME2(3) NOT NULL CONSTRAINT DF_academic_period_updated_at DEFAULT SYSUTCDATETIME(),
        created_by NVARCHAR(128) NOT NULL CONSTRAINT DF_academic_period_created_by DEFAULT
            (COALESCE(CONVERT(NVARCHAR(128), SESSION_CONTEXT(N'app_user')), ORIGINAL_LOGIN())),
        updated_by NVARCHAR(128) NOT NULL CONSTRAINT DF_academic_period_updated_by DEFAULT
            (COALESCE(CONVERT(NVARCHAR(128), SESSION_CONTEXT(N'app_user')), ORIGINAL_LOGIN())),
        CONSTRAINT UQ_academic_period_name_year UNIQUE (period_name, academic_year),
        CONSTRAINT CK_academic_period_dates CHECK (end_date >= start_date),
        CONSTRAINT CK_academic_period_year CHECK (academic_year BETWEEN 2000 AND 2100),
        CONSTRAINT CK_academic_period_status CHECK (status IN (N'ACTIVE',N'INACTIVE'))
    );
END;
GO

/* ============================================================================
   06. STUDENT - Estudiantes
   ============================================================================ */
IF OBJECT_ID(N'dbo.student', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.student (
        student_id INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_student PRIMARY KEY,
        code NVARCHAR(20) NOT NULL,
        document_type NVARCHAR(3) NULL,
        document_number NVARCHAR(20) NULL,
        first_name NVARCHAR(100) NOT NULL,
        last_name NVARCHAR(100) NOT NULL,
        birth_date DATE NULL,
        gender NVARCHAR(1) NULL,
        guardian_name NVARCHAR(100) NULL,
        guardian_phone NVARCHAR(15) NULL,
        guardian_last_name NVARCHAR(100) NULL,
        guardian_relationship NVARCHAR(50) NULL,
        education_level NVARCHAR(15) NOT NULL,
        grade_id BIGINT NOT NULL,
        section_id BIGINT NOT NULL,
        status NVARCHAR(10) NOT NULL CONSTRAINT DF_student_status DEFAULT N'ACTIVE',
        created_at DATETIME2(3) NOT NULL CONSTRAINT DF_student_created_at DEFAULT SYSUTCDATETIME(),
        updated_at DATETIME2(3) NOT NULL CONSTRAINT DF_student_updated_at DEFAULT SYSUTCDATETIME(),
        created_by NVARCHAR(128) NOT NULL CONSTRAINT DF_student_created_by DEFAULT
            (COALESCE(CONVERT(NVARCHAR(128), SESSION_CONTEXT(N'app_user')), ORIGINAL_LOGIN())),
        updated_by NVARCHAR(128) NOT NULL CONSTRAINT DF_student_updated_by DEFAULT
            (COALESCE(CONVERT(NVARCHAR(128), SESSION_CONTEXT(N'app_user')), ORIGINAL_LOGIN())),
        CONSTRAINT UQ_student_code UNIQUE (code),
        CONSTRAINT UQ_student_document UNIQUE (document_type, document_number),
        CONSTRAINT FK_student_grade FOREIGN KEY (grade_id) REFERENCES dbo.grade(grade_id),
        CONSTRAINT FK_student_section FOREIGN KEY (section_id) REFERENCES dbo.section(section_id),
        CONSTRAINT CK_student_gender CHECK (gender IS NULL OR gender IN (N'M',N'F',N'X')),
        CONSTRAINT CK_student_birth_date CHECK (birth_date IS NULL OR birth_date <= CONVERT(DATE, SYSUTCDATETIME())),
        CONSTRAINT CK_student_level CHECK (education_level IN (N'INICIAL',N'PRIMARIA',N'SECUNDARIA')),
        CONSTRAINT CK_student_status CHECK (status IN (N'ACTIVE',N'INACTIVE'))
    );
END;
GO

/* ============================================================================
   07. COURSE - Cursos
   Tipos corregidos: description/education_level/status ya no son INT.
   ============================================================================ */
IF OBJECT_ID(N'dbo.course', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.course (
        course_id INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_course PRIMARY KEY,
        code NVARCHAR(20) NOT NULL,
        course_name NVARCHAR(150) NOT NULL,
        description NVARCHAR(500) NULL,
        education_level NVARCHAR(15) NOT NULL,
        status NVARCHAR(10) NOT NULL CONSTRAINT DF_course_status DEFAULT N'ACTIVE',
        created_at DATETIME2(3) NOT NULL CONSTRAINT DF_course_created_at DEFAULT SYSUTCDATETIME(),
        updated_at DATETIME2(3) NOT NULL CONSTRAINT DF_course_updated_at DEFAULT SYSUTCDATETIME(),
        created_by NVARCHAR(128) NOT NULL CONSTRAINT DF_course_created_by DEFAULT
            (COALESCE(CONVERT(NVARCHAR(128), SESSION_CONTEXT(N'app_user')), ORIGINAL_LOGIN())),
        updated_by NVARCHAR(128) NOT NULL CONSTRAINT DF_course_updated_by DEFAULT
            (COALESCE(CONVERT(NVARCHAR(128), SESSION_CONTEXT(N'app_user')), ORIGINAL_LOGIN())),
        CONSTRAINT UQ_course_code UNIQUE (code),
        CONSTRAINT CK_course_level CHECK (education_level IN (N'INICIAL',N'PRIMARIA',N'SECUNDARIA')),
        CONSTRAINT CK_course_status CHECK (status IN (N'ACTIVE',N'INACTIVE'))
    );
END;
GO

/* ============================================================================
   08. COMPETENCY - Competencias
   ============================================================================ */
IF OBJECT_ID(N'dbo.Competency', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.Competency (
        competency_id INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Competency PRIMARY KEY,
        code NVARCHAR(20) NOT NULL,
        competency_name NVARCHAR(200) NOT NULL,
        description NVARCHAR(500) NULL,
        education_level NVARCHAR(15) NOT NULL,
        status NVARCHAR(10) NOT NULL CONSTRAINT DF_Competency_status DEFAULT N'ACTIVE',
        created_at DATETIME2(3) NOT NULL CONSTRAINT DF_Competency_created_at DEFAULT SYSUTCDATETIME(),
        updated_at DATETIME2(3) NOT NULL CONSTRAINT DF_Competency_updated_at DEFAULT SYSUTCDATETIME(),
        created_by NVARCHAR(128) NOT NULL CONSTRAINT DF_Competency_created_by DEFAULT
            (COALESCE(CONVERT(NVARCHAR(128), SESSION_CONTEXT(N'app_user')), ORIGINAL_LOGIN())),
        updated_by NVARCHAR(128) NOT NULL CONSTRAINT DF_Competency_updated_by DEFAULT
            (COALESCE(CONVERT(NVARCHAR(128), SESSION_CONTEXT(N'app_user')), ORIGINAL_LOGIN())),
        CONSTRAINT UQ_Competency_code UNIQUE (code),
        CONSTRAINT CK_Competency_level CHECK (education_level IN (N'INICIAL',N'PRIMARIA',N'SECUNDARIA')),
        CONSTRAINT CK_Competency_status CHECK (status IN (N'ACTIVE',N'INACTIVE'))
    );
END;
GO

/* ============================================================================
   09. ENROLLMENT - Matrículas
   ============================================================================ */
IF OBJECT_ID(N'dbo.enrollment', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.enrollment (
        enrollment_id INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_enrollment PRIMARY KEY,
        student_id INT NOT NULL,
        education_level NVARCHAR(15) NOT NULL,
        grade_id BIGINT NOT NULL,
        section_id BIGINT NOT NULL,
        academic_period_id INT NOT NULL,
        academic_year SMALLINT NOT NULL,
        enrollment_date DATE NOT NULL CONSTRAINT DF_enrollment_date DEFAULT CONVERT(DATE, SYSUTCDATETIME()),
        guardian_document_number NVARCHAR(20) NULL,
        guardian_first_name NVARCHAR(100) NULL,
        guardian_last_name NVARCHAR(100) NULL,
        guardian_relationship NVARCHAR(50) NULL,
        guardian_phone NVARCHAR(15) NULL,
        status NVARCHAR(15) NOT NULL CONSTRAINT DF_enrollment_status DEFAULT N'ACTIVE',
        created_at DATETIME2(3) NOT NULL CONSTRAINT DF_enrollment_created_at DEFAULT SYSUTCDATETIME(),
        updated_at DATETIME2(3) NOT NULL CONSTRAINT DF_enrollment_updated_at DEFAULT SYSUTCDATETIME(),
        created_by NVARCHAR(128) NOT NULL CONSTRAINT DF_enrollment_created_by DEFAULT
            (COALESCE(CONVERT(NVARCHAR(128), SESSION_CONTEXT(N'app_user')), ORIGINAL_LOGIN())),
        updated_by NVARCHAR(128) NOT NULL CONSTRAINT DF_enrollment_updated_by DEFAULT
            (COALESCE(CONVERT(NVARCHAR(128), SESSION_CONTEXT(N'app_user')), ORIGINAL_LOGIN())),
        CONSTRAINT FK_enrollment_student FOREIGN KEY (student_id) REFERENCES dbo.student(student_id),
        CONSTRAINT FK_enrollment_grade FOREIGN KEY (grade_id) REFERENCES dbo.grade(grade_id),
        CONSTRAINT FK_enrollment_section FOREIGN KEY (section_id) REFERENCES dbo.section(section_id),
        CONSTRAINT FK_enrollment_period FOREIGN KEY (academic_period_id) REFERENCES dbo.academic_period(academic_period_id),
        CONSTRAINT UQ_enrollment_student_period UNIQUE (student_id, academic_period_id),
        CONSTRAINT CK_enrollment_year CHECK (academic_year BETWEEN 2000 AND 2100),
        CONSTRAINT CK_enrollment_level CHECK (education_level IN (N'INICIAL',N'PRIMARIA',N'SECUNDARIA')),
        CONSTRAINT CK_enrollment_status CHECK (status IN (N'ACTIVE',N'INACTIVE',N'WITHDRAWN','COMPLETED'))
    );
END;
GO

/* ============================================================================
   10. ATTENDANCE - Asistencia
   ============================================================================ */
IF OBJECT_ID(N'dbo.attendance', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.attendance (
        attendance_id INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_attendance PRIMARY KEY,
        enrollment_id INT NOT NULL,
        course_id INT NOT NULL,
        academic_period_id INT NOT NULL,
        teacher_id INT NOT NULL,
        attendance_date DATE NOT NULL,
        attendance_status NVARCHAR(15) NOT NULL,
        observation NVARCHAR(500) NULL,
        status NVARCHAR(10) NOT NULL CONSTRAINT DF_attendance_status DEFAULT N'ACTIVE',
        created_at DATETIME2(3) NOT NULL CONSTRAINT DF_attendance_created_at DEFAULT SYSUTCDATETIME(),
        updated_at DATETIME2(3) NOT NULL CONSTRAINT DF_attendance_updated_at DEFAULT SYSUTCDATETIME(),
        created_by NVARCHAR(128) NOT NULL CONSTRAINT DF_attendance_created_by DEFAULT
            (COALESCE(CONVERT(NVARCHAR(128), SESSION_CONTEXT(N'app_user')), ORIGINAL_LOGIN())),
        updated_by NVARCHAR(128) NOT NULL CONSTRAINT DF_attendance_updated_by DEFAULT
            (COALESCE(CONVERT(NVARCHAR(128), SESSION_CONTEXT(N'app_user')), ORIGINAL_LOGIN())),
        CONSTRAINT FK_attendance_enrollment FOREIGN KEY (enrollment_id) REFERENCES dbo.enrollment(enrollment_id),
        CONSTRAINT FK_attendance_course FOREIGN KEY (course_id) REFERENCES dbo.course(course_id),
        CONSTRAINT FK_attendance_period FOREIGN KEY (academic_period_id) REFERENCES dbo.academic_period(academic_period_id),
        CONSTRAINT FK_attendance_teacher FOREIGN KEY (teacher_id) REFERENCES dbo.teacher(teacher_id),
        CONSTRAINT UQ_attendance_enrollment_course_date UNIQUE (enrollment_id, course_id, attendance_date),
        CONSTRAINT CK_attendance_attendance_status CHECK (attendance_status IN (N'PRESENT',N'ABSENT',N'TARDY',N'EXCUSED')),
        CONSTRAINT CK_attendance_status CHECK (status IN (N'ACTIVE',N'INACTIVE'))
    );
END;
GO

/* ============================================================================
   11. GRADE_RECORD - Registro de calificaciones (escala de 0 a 20)
   ============================================================================ */
IF OBJECT_ID(N'dbo.grade_record', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.grade_record (
        grade_record_id INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_grade_record PRIMARY KEY,
        enrollment_id INT NOT NULL,
        competency_id INT NOT NULL,
        course_id INT NOT NULL,
        academic_period_id INT NOT NULL,
        teacher_id INT NOT NULL,
        grade_values DECIMAL(4,2) NOT NULL,
        observation NVARCHAR(500) NULL,
        recorded_date DATE NOT NULL CONSTRAINT DF_grade_record_recorded_date DEFAULT CONVERT(DATE, SYSUTCDATETIME()),
        status NVARCHAR(10) NOT NULL CONSTRAINT DF_grade_record_status DEFAULT N'ACTIVE',
        created_at DATETIME2(3) NOT NULL CONSTRAINT DF_grade_record_created_at DEFAULT SYSUTCDATETIME(),
        updated_at DATETIME2(3) NOT NULL CONSTRAINT DF_grade_record_updated_at DEFAULT SYSUTCDATETIME(),
        created_by NVARCHAR(128) NOT NULL CONSTRAINT DF_grade_record_created_by DEFAULT
            (COALESCE(CONVERT(NVARCHAR(128), SESSION_CONTEXT(N'app_user')), ORIGINAL_LOGIN())),
        updated_by NVARCHAR(128) NOT NULL CONSTRAINT DF_grade_record_updated_by DEFAULT
            (COALESCE(CONVERT(NVARCHAR(128), SESSION_CONTEXT(N'app_user')), ORIGINAL_LOGIN())),
        CONSTRAINT FK_grade_record_enrollment FOREIGN KEY (enrollment_id) REFERENCES dbo.enrollment(enrollment_id),
        CONSTRAINT FK_grade_record_competency FOREIGN KEY (competency_id) REFERENCES dbo.Competency(competency_id),
        CONSTRAINT FK_grade_record_course FOREIGN KEY (course_id) REFERENCES dbo.course(course_id),
        CONSTRAINT FK_grade_record_period FOREIGN KEY (academic_period_id) REFERENCES dbo.academic_period(academic_period_id),
        CONSTRAINT FK_grade_record_teacher FOREIGN KEY (teacher_id) REFERENCES dbo.teacher(teacher_id),
        CONSTRAINT CK_grade_record_value CHECK (grade_values BETWEEN 0 AND 20),
        CONSTRAINT CK_grade_record_status CHECK (status IN (N'ACTIVE',N'INACTIVE'))
    );
END;
GO

/* ============================================================================
   12. COPY_OF_COURSE - Tabla heredada conservada por compatibilidad
   ============================================================================ */
IF OBJECT_ID(N'dbo.Copy_of_course', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.Copy_of_course (
        course_id INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Copy_of_course PRIMARY KEY,
        code NVARCHAR(20) NOT NULL,
        course_name NVARCHAR(150) NOT NULL,
        description NVARCHAR(255) NULL,
        education_level NVARCHAR(15) NOT NULL,
        teacher_id INT NULL,
        status NVARCHAR(10) NOT NULL CONSTRAINT DF_Copy_of_course_status DEFAULT N'ACTIVE',
        created_at DATETIME2(3) NOT NULL CONSTRAINT DF_Copy_of_course_created_at DEFAULT SYSUTCDATETIME(),
        updated_at DATETIME2(3) NOT NULL CONSTRAINT DF_Copy_of_course_updated_at DEFAULT SYSUTCDATETIME(),
        created_by NVARCHAR(128) NOT NULL CONSTRAINT DF_Copy_of_course_created_by DEFAULT
            (COALESCE(CONVERT(NVARCHAR(128), SESSION_CONTEXT(N'app_user')), ORIGINAL_LOGIN())),
        updated_by NVARCHAR(128) NOT NULL CONSTRAINT DF_Copy_of_course_updated_by DEFAULT
            (COALESCE(CONVERT(NVARCHAR(128), SESSION_CONTEXT(N'app_user')), ORIGINAL_LOGIN())),
        CONSTRAINT UQ_Copy_of_course_code UNIQUE (code),
        CONSTRAINT FK_Copy_of_course_teacher FOREIGN KEY (teacher_id) REFERENCES dbo.teacher(teacher_id),
        CONSTRAINT CK_Copy_of_course_level CHECK (education_level IN (N'INICIAL',N'PRIMARIA',N'SECUNDARIA')),
        CONSTRAINT CK_Copy_of_course_status CHECK (status IN (N'ACTIVE',N'INACTIVE'))
    );
END;
GO

/* ============================================================================
   13. COPY_OF_COMPETENCY - Tabla heredada conservada por compatibilidad
   ============================================================================ */
IF OBJECT_ID(N'dbo.Copy_of_Competency', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.Copy_of_Competency (
        competency_id INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Copy_of_Competency PRIMARY KEY,
        code NVARCHAR(20) NOT NULL,
        competency_name NVARCHAR(200) NOT NULL,
        description NVARCHAR(500) NULL,
        course_id INT NOT NULL,
        education_level NVARCHAR(15) NOT NULL,
        status NVARCHAR(10) NOT NULL CONSTRAINT DF_Copy_of_Competency_status DEFAULT N'ACTIVE',
        created_at DATETIME2(3) NOT NULL CONSTRAINT DF_Copy_of_Competency_created_at DEFAULT SYSUTCDATETIME(),
        updated_at DATETIME2(3) NOT NULL CONSTRAINT DF_Copy_of_Competency_updated_at DEFAULT SYSUTCDATETIME(),
        created_by NVARCHAR(128) NOT NULL CONSTRAINT DF_Copy_of_Competency_created_by DEFAULT
            (COALESCE(CONVERT(NVARCHAR(128), SESSION_CONTEXT(N'app_user')), ORIGINAL_LOGIN())),
        updated_by NVARCHAR(128) NOT NULL CONSTRAINT DF_Copy_of_Competency_updated_by DEFAULT
            (COALESCE(CONVERT(NVARCHAR(128), SESSION_CONTEXT(N'app_user')), ORIGINAL_LOGIN())),
        CONSTRAINT UQ_Copy_of_Competency_code UNIQUE (code),
        CONSTRAINT FK_Copy_of_Competency_course FOREIGN KEY (course_id) REFERENCES dbo.Copy_of_course(course_id),
        CONSTRAINT CK_Copy_of_Competency_level CHECK (education_level IN (N'INICIAL',N'PRIMARIA',N'SECUNDARIA')),
        CONSTRAINT CK_Copy_of_Competency_status CHECK (status IN (N'ACTIVE',N'INACTIVE'))
    );
END;
GO

/* ============================================================================
   14. COPY_OF_CURSE_GRADE - Relación heredada entre grado y curso
   Se conserva el nombre físico original para evitar romper código existente.
   ============================================================================ */
IF OBJECT_ID(N'dbo.Copy_of_curse__grade', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.Copy_of_curse__grade (
        curse_id INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Copy_of_curse__grade PRIMARY KEY,
        grade_id BIGINT NOT NULL,
        course_id INT NOT NULL,
        created_at DATETIME2(3) NOT NULL CONSTRAINT DF_Copy_of_curse_grade_created_at DEFAULT SYSUTCDATETIME(),
        CONSTRAINT FK_Copy_of_curse_grade_grade FOREIGN KEY (grade_id) REFERENCES dbo.grade(grade_id),
        CONSTRAINT FK_Copy_of_curse_grade_course FOREIGN KEY (course_id) REFERENCES dbo.Copy_of_course(course_id),
        CONSTRAINT UQ_Copy_of_curse_grade UNIQUE (grade_id, course_id)
    );
END;
GO

/* ============================================================================
   15. ÍNDICES - Claves foráneas y búsquedas frecuentes
   ============================================================================ */
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name=N'IX_classroom_grade_section' AND object_id=OBJECT_ID(N'dbo.classroom'))
    CREATE INDEX IX_classroom_grade_section ON dbo.classroom(grade_id, section_id);
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name=N'IX_student_last_name' AND object_id=OBJECT_ID(N'dbo.student'))
    CREATE INDEX IX_student_last_name ON dbo.student(last_name, first_name);
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name=N'IX_enrollment_period' AND object_id=OBJECT_ID(N'dbo.enrollment'))
    CREATE INDEX IX_enrollment_period ON dbo.enrollment(academic_period_id, status);
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name=N'IX_attendance_date' AND object_id=OBJECT_ID(N'dbo.attendance'))
    CREATE INDEX IX_attendance_date ON dbo.attendance(attendance_date, course_id);
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name=N'IX_grade_record_enrollment_period' AND object_id=OBJECT_ID(N'dbo.grade_record'))
    CREATE INDEX IX_grade_record_enrollment_period ON dbo.grade_record(enrollment_id, academic_period_id);
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name=N'IX_audit_log_table_date' AND object_id=OBJECT_ID(N'dbo.audit_log'))
    CREATE INDEX IX_audit_log_table_date ON dbo.audit_log(table_name, changed_at DESC);
GO

/* ============================================================================
   16. TRIGGERS - Actualizar updated_at y registrar operaciones
   Se crean solo si no existen. Se usa SQL dinámico para mantener el script
   compatible con tablas creadas anteriormente.
   ============================================================================ */
DECLARE @tables TABLE (table_name SYSNAME);
INSERT INTO @tables(table_name) VALUES
(N'grade'),(N'section'),(N'teacher'),(N'classroom'),(N'academic_period'),
(N'student'),(N'course'),(N'Competency'),(N'enrollment'),(N'attendance'),
(N'grade_record'),(N'Copy_of_course'),(N'Copy_of_Competency');

DECLARE @table SYSNAME, @sql NVARCHAR(MAX), @trigger SYSNAME;
DECLARE cur CURSOR LOCAL FAST_FORWARD FOR SELECT table_name FROM @tables;
OPEN cur;
FETCH NEXT FROM cur INTO @table;
WHILE @@FETCH_STATUS = 0
BEGIN
    SET @trigger = N'TRG_' + @table + N'_Audit';
    IF OBJECT_ID(N'dbo.' + @trigger, N'TR') IS NULL
    BEGIN
        SET @sql = N'CREATE TRIGGER dbo.' + QUOTENAME(@trigger) + N' ON dbo.' + QUOTENAME(@table) + N'
        AFTER INSERT, UPDATE, DELETE
        AS
        BEGIN
            SET NOCOUNT ON;
            IF TRIGGER_NESTLEVEL() > 1 RETURN;

            IF EXISTS (SELECT 1 FROM inserted) AND EXISTS (SELECT 1 FROM deleted)
            BEGIN
                UPDATE t
                SET updated_at = SYSUTCDATETIME(),
                    updated_by = COALESCE(CONVERT(NVARCHAR(128), SESSION_CONTEXT(N''app_user'')), ORIGINAL_LOGIN())
                FROM dbo.' + QUOTENAME(@table) + N' AS t
                INNER JOIN inserted AS i ON ' +
                CASE @table
                    WHEN N'grade' THEN N't.grade_id = i.grade_id'
                    WHEN N'section' THEN N't.section_id = i.section_id'
                    WHEN N'teacher' THEN N't.teacher_id = i.teacher_id'
                    WHEN N'classroom' THEN N't.classroom_id = i.classroom_id'
                    WHEN N'academic_period' THEN N't.academic_period_id = i.academic_period_id'
                    WHEN N'student' THEN N't.student_id = i.student_id'
                    WHEN N'course' THEN N't.course_id = i.course_id'
                    WHEN N'Competency' THEN N't.competency_id = i.competency_id'
                    WHEN N'enrollment' THEN N't.enrollment_id = i.enrollment_id'
                    WHEN N'attendance' THEN N't.attendance_id = i.attendance_id'
                    WHEN N'grade_record' THEN N't.grade_record_id = i.grade_record_id'
                    WHEN N'Copy_of_course' THEN N't.course_id = i.course_id'
                    WHEN N'Copy_of_Competency' THEN N't.competency_id = i.competency_id'
                END + N';
            END;

            INSERT INTO dbo.audit_log(table_name, operation_type, record_key, details)
            SELECT N''' + REPLACE(@table,'''','''''') + N''',
                   CASE WHEN d.key_value IS NULL THEN ''INSERT''
                        WHEN i.key_value IS NULL THEN ''DELETE'' ELSE ''UPDATE'' END,
                   COALESCE(i.key_value, d.key_value),
                   N''Cambio registrado por trigger.''
            FROM
              (SELECT ' +
                CASE @table
                    WHEN N'grade' THEN N'CONVERT(NVARCHAR(200), grade_id)'
                    WHEN N'section' THEN N'CONVERT(NVARCHAR(200), section_id)'
                    WHEN N'teacher' THEN N'CONVERT(NVARCHAR(200), teacher_id)'
                    WHEN N'classroom' THEN N'CONVERT(NVARCHAR(200), classroom_id)'
                    WHEN N'academic_period' THEN N'CONVERT(NVARCHAR(200), academic_period_id)'
                    WHEN N'student' THEN N'CONVERT(NVARCHAR(200), student_id)'
                    WHEN N'course' THEN N'CONVERT(NVARCHAR(200), course_id)'
                    WHEN N'Competency' THEN N'CONVERT(NVARCHAR(200), competency_id)'
                    WHEN N'enrollment' THEN N'CONVERT(NVARCHAR(200), enrollment_id)'
                    WHEN N'attendance' THEN N'CONVERT(NVARCHAR(200), attendance_id)'
                    WHEN N'grade_record' THEN N'CONVERT(NVARCHAR(200), grade_record_id)'
                    WHEN N'Copy_of_course' THEN N'CONVERT(NVARCHAR(200), course_id)'
                    WHEN N'Copy_of_Competency' THEN N'CONVERT(NVARCHAR(200), competency_id)'
                END + N' AS key_value FROM inserted) i
            FULL OUTER JOIN
              (SELECT ' +
                CASE @table
                    WHEN N'grade' THEN N'CONVERT(NVARCHAR(200), grade_id)'
                    WHEN N'section' THEN N'CONVERT(NVARCHAR(200), section_id)'
                    WHEN N'teacher' THEN N'CONVERT(NVARCHAR(200), teacher_id)'
                    WHEN N'classroom' THEN N'CONVERT(NVARCHAR(200), classroom_id)'
                    WHEN N'academic_period' THEN N'CONVERT(NVARCHAR(200), academic_period_id)'
                    WHEN N'student' THEN N'CONVERT(NVARCHAR(200), student_id)'
                    WHEN N'course' THEN N'CONVERT(NVARCHAR(200), course_id)'
                    WHEN N'Competency' THEN N'CONVERT(NVARCHAR(200), competency_id)'
                    WHEN N'enrollment' THEN N'CONVERT(NVARCHAR(200), enrollment_id)'
                    WHEN N'attendance' THEN N'CONVERT(NVARCHAR(200), attendance_id)'
                    WHEN N'grade_record' THEN N'CONVERT(NVARCHAR(200), grade_record_id)'
                    WHEN N'Copy_of_course' THEN N'CONVERT(NVARCHAR(200), course_id)'
                    WHEN N'Copy_of_Competency' THEN N'CONVERT(NVARCHAR(200), competency_id)'
                END + N' AS key_value FROM deleted) d ON i.key_value = d.key_value;
        END;';
        EXEC sys.sp_executesql @sql;
    END;
    FETCH NEXT FROM cur INTO @table;
END;
CLOSE cur;
DEALLOCATE cur;
GO

/* ============================================================================
   17. VERIFICACIÓN FINAL
   ============================================================================ */
SELECT DB_NAME() AS database_name;
SELECT t.name AS table_name
FROM sys.tables AS t
WHERE t.is_ms_shipped = 0
ORDER BY t.name;
GO

/*
NOTAS PARA EL BACKEND SPRING BOOT
- Actualizar application.yaml para usar databaseName=BD_Gestion_Academica_v2.
- Hibernate debe usar ddl-auto: none; el esquema lo controla este script.
- Si se cambia SESSION_CONTEXT desde la aplicación, establecer app_user al abrir
  cada conexión/transacción para identificar al usuario real en auditoría.
- Las restricciones de educación/estado aceptan valores en inglés para status
  (ACTIVE/INACTIVE) y niveles en español (INICIAL/PRIMARIA/SECUNDARIA).
- Si ya existían tablas con estructura antigua, IF OBJECT_ID evita recrearlas,
  pero NO modifica sus columnas ni agrega automáticamente las nuevas restricciones.
  Para actualizar una base existente se requiere un script de migración específico.
*/
