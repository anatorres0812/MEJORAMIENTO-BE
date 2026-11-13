package pe.edu.vallegrande.crud.model;

import jakarta.persistence.*;

@Entity
@Table(name="course", schema="dbo")
public class Course extends AuditableEntity {
 @Id
 @GeneratedValue(strategy=GenerationType.IDENTITY)
 @Column(name="course_id")
 private Integer courseId;
 @Column(name="code", nullable=false, length=20)
 private String code;
 @Column(name="course_name", nullable=false, length=150)
 private String courseName;
 @Column(name="description", length=500)
 private String description;
 @Column(name="education_level", nullable=false, length=15)
 private String educationLevel;
 @Column(name="status", nullable=false, length=10)
 private String status;

 public Course() {}
 public Integer getCourseId() { return courseId; }
 public void setCourseId(Integer courseId) { this.courseId = courseId; }
 public String getCode() { return code; }
 public void setCode(String code) { this.code = code; }
 public String getCourseName() { return courseName; }
 public void setCourseName(String courseName) { this.courseName = courseName; }
 public String getDescription() { return description; }
 public void setDescription(String description) { this.description = description; }
 public String getEducationLevel() { return educationLevel; }
 public void setEducationLevel(String educationLevel) { this.educationLevel = educationLevel; }
 public String getStatus() { return status; }
 public void setStatus(String status) { this.status = status; }
}
