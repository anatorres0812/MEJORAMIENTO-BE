package pe.edu.vallegrande.crud.model;

import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name="teacher", schema="dbo")
public class Teacher extends AuditableEntity {
 @Id
 @GeneratedValue(strategy=GenerationType.IDENTITY)
 @Column(name="teacher_id")
 private Integer teacherId;
 @Column(name="document_type", nullable=false, length=10)
 private String documentType;
 @Column(name="document_number", nullable=false, length=20)
 private String documentNumber;
 @Column(name="first_name", nullable=false, length=100)
 private String firstName;
 @Column(name="last_name", nullable=false, length=100)
 private String lastName;
 @Column(name="specialty", length=150)
 private String specialty;
 @Column(name="education_level", length=15)
 private String educationLevel;
 @Column(name="phone", length=15)
 private String phone;
 @Column(name="email", length=150)
 private String email;
 @Column(name="hire_date")
 private LocalDate hireDate;
 @Column(name="status", nullable=false, length=10)
 private String status;

 public Teacher() {}
 public Integer getTeacherId() { return teacherId; }
 public void setTeacherId(Integer teacherId) { this.teacherId = teacherId; }
 public String getDocumentType() { return documentType; }
 public void setDocumentType(String documentType) { this.documentType = documentType; }
 public String getDocumentNumber() { return documentNumber; }
 public void setDocumentNumber(String documentNumber) { this.documentNumber = documentNumber; }
 public String getFirstName() { return firstName; }
 public void setFirstName(String firstName) { this.firstName = firstName; }
 public String getLastName() { return lastName; }
 public void setLastName(String lastName) { this.lastName = lastName; }
 public String getSpecialty() { return specialty; }
 public void setSpecialty(String specialty) { this.specialty = specialty; }
 public String getEducationLevel() { return educationLevel; }
 public void setEducationLevel(String educationLevel) { this.educationLevel = educationLevel; }
 public String getPhone() { return phone; }
 public void setPhone(String phone) { this.phone = phone; }
 public String getEmail() { return email; }
 public void setEmail(String email) { this.email = email; }
 public LocalDate getHireDate() { return hireDate; }
 public void setHireDate(LocalDate hireDate) { this.hireDate = hireDate; }
 public String getStatus() { return status; }
 public void setStatus(String status) { this.status = status; }
}
