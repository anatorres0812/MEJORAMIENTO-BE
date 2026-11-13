/*
  TORRESANA - Extension compatible con BD_Gestion_Academica_v2
  No elimina ni renombra tablas/columnas existentes. Ejecutar primero en desarrollo.
*/
USE BD_Gestion_Academica_v2;
GO
IF OBJECT_ID('dbo.guardian','U') IS NULL
BEGIN
 CREATE TABLE dbo.guardian(
  guardian_id INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_guardian PRIMARY KEY,
  document_type NVARCHAR(10) NOT NULL, document_number NVARCHAR(20) NOT NULL,
  first_name NVARCHAR(100) NOT NULL, last_name NVARCHAR(100) NOT NULL,
  phone NVARCHAR(20) NOT NULL, email NVARCHAR(150) NULL,
  created_at DATETIME2(3) NOT NULL CONSTRAINT DF_guardian_created DEFAULT SYSUTCDATETIME(),
  updated_at DATETIME2(3) NULL,
  CONSTRAINT UQ_guardian_document UNIQUE(document_type,document_number),
  CONSTRAINT CK_guardian_phone CHECK(phone NOT LIKE '%[^0-9]%' AND LEN(phone)=9 AND LEFT(phone,1)='9'),
  CONSTRAINT CK_guardian_email CHECK(email IS NULL OR email LIKE '%_@_%.__%' AND (email LIKE '%.com' OR email LIKE '%.edu.pe'))
 );
END;
GO
IF OBJECT_ID('dbo.student_guardian','U') IS NULL
BEGIN
 CREATE TABLE dbo.student_guardian(
  student_id INT NOT NULL, guardian_id INT NOT NULL,
  relationship NVARCHAR(50) NOT NULL,
  is_primary BIT NOT NULL CONSTRAINT DF_student_guardian_primary DEFAULT(0),
  CONSTRAINT PK_student_guardian PRIMARY KEY(student_id,guardian_id),
  CONSTRAINT FK_student_guardian_student FOREIGN KEY(student_id) REFERENCES dbo.student(student_id),
  CONSTRAINT FK_student_guardian_guardian FOREIGN KEY(guardian_id) REFERENCES dbo.guardian(guardian_id)
 );
 CREATE UNIQUE INDEX UX_student_guardian_primary ON dbo.student_guardian(student_id) WHERE is_primary=1;
END;
GO
IF OBJECT_ID('dbo.section_course','U') IS NULL
BEGIN
 CREATE TABLE dbo.section_course(
  section_course_id INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_section_course PRIMARY KEY,
  section_id BIGINT NOT NULL, course_id INT NOT NULL, teacher_id INT NOT NULL,
  status NVARCHAR(15) NOT NULL CONSTRAINT DF_section_course_status DEFAULT N'ACTIVE',
  created_at DATETIME2(3) NOT NULL CONSTRAINT DF_section_course_created DEFAULT SYSUTCDATETIME(),
  updated_at DATETIME2(3) NULL,
  CONSTRAINT FK_section_course_section FOREIGN KEY(section_id) REFERENCES dbo.section(section_id),
  CONSTRAINT FK_section_course_course FOREIGN KEY(course_id) REFERENCES dbo.course(course_id),
  CONSTRAINT FK_section_course_teacher FOREIGN KEY(teacher_id) REFERENCES dbo.teacher(teacher_id),
  CONSTRAINT UQ_section_course UNIQUE(section_id,course_id)
 );
END;
GO
IF OBJECT_ID('dbo.assessment','U') IS NULL
BEGIN
 CREATE TABLE dbo.assessment(
  assessment_id INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_assessment PRIMARY KEY,
  section_course_id INT NOT NULL, competency_id INT NOT NULL,
  assessment_name NVARCHAR(150) NOT NULL, assessment_date DATE NOT NULL,
  maximum_score DECIMAL(5,2) NOT NULL,
  status NVARCHAR(15) NOT NULL CONSTRAINT DF_assessment_status DEFAULT N'PROGRAMADA',
  created_at DATETIME2(3) NOT NULL CONSTRAINT DF_assessment_created DEFAULT SYSUTCDATETIME(),
  updated_at DATETIME2(3) NULL,
  CONSTRAINT FK_assessment_section_course FOREIGN KEY(section_course_id) REFERENCES dbo.section_course(section_course_id),
  CONSTRAINT FK_assessment_competency FOREIGN KEY(competency_id) REFERENCES dbo.Competency(competency_id),
  CONSTRAINT CK_assessment_maximum_score CHECK(maximum_score>0)
 );
END;
GO
IF COL_LENGTH('dbo.grade_record','assessment_id') IS NULL
 ALTER TABLE dbo.grade_record ADD assessment_id INT NULL;
GO
IF NOT EXISTS(SELECT 1 FROM sys.foreign_keys WHERE name='FK_grade_record_assessment')
 ALTER TABLE dbo.grade_record ADD CONSTRAINT FK_grade_record_assessment FOREIGN KEY(assessment_id) REFERENCES dbo.assessment(assessment_id);
GO
IF COL_LENGTH('dbo.attendance','section_course_id') IS NULL
 ALTER TABLE dbo.attendance ADD section_course_id INT NULL;
GO
IF NOT EXISTS(SELECT 1 FROM sys.foreign_keys WHERE name='FK_attendance_section_course')
 ALTER TABLE dbo.attendance ADD CONSTRAINT FK_attendance_section_course FOREIGN KEY(section_course_id) REFERENCES dbo.section_course(section_course_id);
GO
-- Migracion de apoderados desde los campos historicos del estudiante, sin borrar los originales.
INSERT INTO dbo.guardian(document_type,document_number,first_name,last_name,phone)
SELECT N'OTRO', s.code + N'-APO', s.guardian_name, COALESCE(s.guardian_last_name,N''), s.guardian_phone
FROM dbo.student s
WHERE NULLIF(LTRIM(RTRIM(s.guardian_name)),N'') IS NOT NULL
 AND NULLIF(LTRIM(RTRIM(s.guardian_phone)),N'') IS NOT NULL
 AND LEN(s.guardian_phone)=9 AND s.guardian_phone NOT LIKE '%[^0-9]%'
 AND LEFT(s.guardian_phone,1)='9'
 AND NOT EXISTS(SELECT 1 FROM dbo.guardian g WHERE g.document_number=s.code+N'-APO');
GO
INSERT INTO dbo.student_guardian(student_id,guardian_id,relationship,is_primary)
SELECT s.student_id,g.guardian_id,COALESCE(s.guardian_relationship,N'Apoderado'),1
FROM dbo.student s JOIN dbo.guardian g ON g.document_number=s.code+N'-APO'
WHERE NOT EXISTS(SELECT 1 FROM dbo.student_guardian sg WHERE sg.student_id=s.student_id AND sg.guardian_id=g.guardian_id);
GO
