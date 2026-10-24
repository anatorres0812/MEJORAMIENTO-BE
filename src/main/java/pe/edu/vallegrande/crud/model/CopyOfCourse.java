package pe.edu.vallegrande.crud.model;

import jakarta.persistence.*;

@Entity
@Table(name="Copy_of_course", schema="dbo")
public class CopyOfCourse extends AuditableEntity {
 @Id
 @GeneratedValue(strategy=GenerationType.IDENTITY)
 @Column(name="course_id")
 private Integer courseId;
 @Column(name="code", nullable=false, length=20)
 private String code;
 @Column(name="course_name", nullable=false, length=150)
 private String courseName;
 @Column(name="description", length=255)
 private String description;
 @Column(name="education_level", nullable=false, length=15)
 private String educationLevel;
 @Column(name="teacher_id")
 private Integer teacherId;
 @Column(name="status", nullable=false, length=10)
 private String status;

 public CopyOfCourse() {}
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
 public Integer getTeacherId() { return teacherId; }
 public void setTeacherId(Integer teacherId) { this.teacherId = teacherId; }
 public String getStatus() { return status; }
 public void setStatus(String status) { this.status = status; }
}
