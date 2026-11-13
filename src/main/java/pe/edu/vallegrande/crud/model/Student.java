package pe.edu.vallegrande.crud.model;

import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name="student", schema="dbo")
public class Student extends AuditableEntity {
 @Id
 @GeneratedValue(strategy=GenerationType.IDENTITY)
 @Column(name="student_id")
 private Integer studentId;
 @Column(name="code", nullable=false, length=20)
 private String code;
 @Column(name="document_type", length=3)
 private String documentType;
 @Column(name="document_number", length=20)
 private String documentNumber;
 @Column(name="first_name", nullable=false, length=100)
 private String firstName;
 @Column(name="last_name", nullable=false, length=100)
 private String lastName;
 @Column(name="birth_date")
 private LocalDate birthDate;
 @Column(name="gender", length=1)
 private String gender;
 @Column(name="guardian_name", length=100)
 private String guardianName;
 @Column(name="guardian_phone", length=15)
 private String guardianPhone;
 @Column(name="guardian_last_name", length=100)
 private String guardianLastName;
 @Column(name="guardian_relationship", length=50)
 private String guardianRelationship;
 @Column(name="education_level", nullable=false, length=15)
 private String educationLevel;
 @Column(name="grade_id", nullable=false)
 private Long gradeId;
 @Column(name="section_id", nullable=false)
 private Long sectionId;
 @Column(name="status", nullable=false, length=10)
 private String status;

 public Student() {}
 public Integer getStudentId() { return studentId; }
 public void setStudentId(Integer studentId) { this.studentId = studentId; }
 public String getCode() { return code; }
 public void setCode(String code) { this.code = code; }
 public String getDocumentType() { return documentType; }
 public void setDocumentType(String documentType) { this.documentType = documentType; }
 public String getDocumentNumber() { return documentNumber; }
 public void setDocumentNumber(String documentNumber) { this.documentNumber = documentNumber; }
 public String getFirstName() { return firstName; }
 public void setFirstName(String firstName) { this.firstName = firstName; }
 public String getLastName() { return lastName; }
 public void setLastName(String lastName) { this.lastName = lastName; }
 public LocalDate getBirthDate() { return birthDate; }
 public void setBirthDate(LocalDate birthDate) { this.birthDate = birthDate; }
 public String getGender() { return gender; }
 public void setGender(String gender) { this.gender = gender; }
 public String getGuardianName() { return guardianName; }
 public void setGuardianName(String guardianName) { this.guardianName = guardianName; }
 public String getGuardianPhone() { return guardianPhone; }
 public void setGuardianPhone(String guardianPhone) { this.guardianPhone = guardianPhone; }
 public String getGuardianLastName() { return guardianLastName; }
 public void setGuardianLastName(String guardianLastName) { this.guardianLastName = guardianLastName; }
 public String getGuardianRelationship() { return guardianRelationship; }
 public void setGuardianRelationship(String guardianRelationship) { this.guardianRelationship = guardianRelationship; }
 public String getEducationLevel() { return educationLevel; }
 public void setEducationLevel(String educationLevel) { this.educationLevel = educationLevel; }
 public Long getGradeId() { return gradeId; }
 public void setGradeId(Long gradeId) { this.gradeId = gradeId; }
 public Long getSectionId() { return sectionId; }
 public void setSectionId(Long sectionId) { this.sectionId = sectionId; }
 public String getStatus() { return status; }
 public void setStatus(String status) { this.status = status; }
}
