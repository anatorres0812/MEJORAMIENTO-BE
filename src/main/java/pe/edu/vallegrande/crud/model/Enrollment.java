package pe.edu.vallegrande.crud.model;

import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name="enrollment", schema="dbo")
public class Enrollment extends AuditableEntity {
 @Id
 @GeneratedValue(strategy=GenerationType.IDENTITY)
 @Column(name="enrollment_id")
 private Integer enrollmentId;
 @Column(name="student_id", nullable=false)
 private Integer studentId;
 @Column(name="education_level", nullable=false, length=15)
 private String educationLevel;
 @Column(name="grade_id", nullable=false)
 private Long gradeId;
 @Column(name="section_id", nullable=false)
 private Long sectionId;
 @Column(name="academic_period_id", nullable=false)
 private Integer academicPeriodId;
 @Column(name="academic_year", nullable=false)
 private Integer academicYear;
 @Column(name="enrollment_date", nullable=false)
 private LocalDate enrollmentDate;
 @Column(name="guardian_document_number", length=20)
 private String guardianDocumentNumber;
 @Column(name="guardian_first_name", length=100)
 private String guardianFirstName;
 @Column(name="guardian_last_name", length=100)
 private String guardianLastName;
 @Column(name="guardian_relationship", length=50)
 private String guardianRelationship;
 @Column(name="guardian_phone", length=15)
 private String guardianPhone;
 @Column(name="status", nullable=false, length=15)
 private String status;

 public Enrollment() {}
 public Integer getEnrollmentId() { return enrollmentId; }
 public void setEnrollmentId(Integer enrollmentId) { this.enrollmentId = enrollmentId; }
 public Integer getStudentId() { return studentId; }
 public void setStudentId(Integer studentId) { this.studentId = studentId; }
 public String getEducationLevel() { return educationLevel; }
 public void setEducationLevel(String educationLevel) { this.educationLevel = educationLevel; }
 public Long getGradeId() { return gradeId; }
 public void setGradeId(Long gradeId) { this.gradeId = gradeId; }
 public Long getSectionId() { return sectionId; }
 public void setSectionId(Long sectionId) { this.sectionId = sectionId; }
 public Integer getAcademicPeriodId() { return academicPeriodId; }
 public void setAcademicPeriodId(Integer academicPeriodId) { this.academicPeriodId = academicPeriodId; }
 public Integer getAcademicYear() { return academicYear; }
 public void setAcademicYear(Integer academicYear) { this.academicYear = academicYear; }
 public LocalDate getEnrollmentDate() { return enrollmentDate; }
 public void setEnrollmentDate(LocalDate enrollmentDate) { this.enrollmentDate = enrollmentDate; }
 public String getGuardianDocumentNumber() { return guardianDocumentNumber; }
 public void setGuardianDocumentNumber(String guardianDocumentNumber) { this.guardianDocumentNumber = guardianDocumentNumber; }
 public String getGuardianFirstName() { return guardianFirstName; }
 public void setGuardianFirstName(String guardianFirstName) { this.guardianFirstName = guardianFirstName; }
 public String getGuardianLastName() { return guardianLastName; }
 public void setGuardianLastName(String guardianLastName) { this.guardianLastName = guardianLastName; }
 public String getGuardianRelationship() { return guardianRelationship; }
 public void setGuardianRelationship(String guardianRelationship) { this.guardianRelationship = guardianRelationship; }
 public String getGuardianPhone() { return guardianPhone; }
 public void setGuardianPhone(String guardianPhone) { this.guardianPhone = guardianPhone; }
 public String getStatus() { return status; }
 public void setStatus(String status) { this.status = status; }
}
