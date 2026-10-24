package pe.edu.vallegrande.crud.model;

import jakarta.persistence.*;

@Entity
@Table(name="grade", schema="dbo")
public class Grade extends AuditableEntity {
 @Id
 @GeneratedValue(strategy=GenerationType.IDENTITY)
 @Column(name="grade_id")
 private Long gradeId;
 @Column(name="grade_name", nullable=false, length=100)
 private String gradeName;
 @Column(name="education_level", nullable=false, length=15)
 private String educationLevel;
 @Column(name="grade_order", nullable=false)
 private Integer gradeOrder;
 @Column(name="description", length=255)
 private String description;
 @Column(name="status", nullable=false, length=10)
 private String status;

 public Grade() {}
 public Long getGradeId() { return gradeId; }
 public void setGradeId(Long gradeId) { this.gradeId = gradeId; }
 public String getGradeName() { return gradeName; }
 public void setGradeName(String gradeName) { this.gradeName = gradeName; }
 public String getEducationLevel() { return educationLevel; }
 public void setEducationLevel(String educationLevel) { this.educationLevel = educationLevel; }
 public Integer getGradeOrder() { return gradeOrder; }
 public void setGradeOrder(Integer gradeOrder) { this.gradeOrder = gradeOrder; }
 public String getDescription() { return description; }
 public void setDescription(String description) { this.description = description; }
 public String getStatus() { return status; }
 public void setStatus(String status) { this.status = status; }
}
