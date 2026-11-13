package pe.edu.vallegrande.crud.model;

import jakarta.persistence.*;

@Entity
@Table(name="Copy_of_Competency", schema="dbo")
public class CopyOfCompetency extends AuditableEntity {
 @Id
 @GeneratedValue(strategy=GenerationType.IDENTITY)
 @Column(name="competency_id")
 private Integer competencyId;
 @Column(name="code", nullable=false, length=20)
 private String code;
 @Column(name="competency_name", nullable=false, length=200)
 private String competencyName;
 @Column(name="description", length=500)
 private String description;
 @Column(name="course_id", nullable=false)
 private Integer courseId;
 @Column(name="education_level", nullable=false, length=15)
 private String educationLevel;
 @Column(name="status", nullable=false, length=10)
 private String status;

 public CopyOfCompetency() {}
 public Integer getCompetencyId() { return competencyId; }
 public void setCompetencyId(Integer competencyId) { this.competencyId = competencyId; }
 public String getCode() { return code; }
 public void setCode(String code) { this.code = code; }
 public String getCompetencyName() { return competencyName; }
 public void setCompetencyName(String competencyName) { this.competencyName = competencyName; }
 public String getDescription() { return description; }
 public void setDescription(String description) { this.description = description; }
 public Integer getCourseId() { return courseId; }
 public void setCourseId(Integer courseId) { this.courseId = courseId; }
 public String getEducationLevel() { return educationLevel; }
 public void setEducationLevel(String educationLevel) { this.educationLevel = educationLevel; }
 public String getStatus() { return status; }
 public void setStatus(String status) { this.status = status; }
}
