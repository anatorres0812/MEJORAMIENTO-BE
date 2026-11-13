package pe.edu.vallegrande.crud.model;

import jakarta.persistence.*;

@Entity
@Table(name="classroom", schema="dbo")
public class Classroom extends AuditableEntity {
 @Id
 @GeneratedValue(strategy=GenerationType.IDENTITY)
 @Column(name="classroom_id")
 private Integer classroomId;
 @Column(name="code", nullable=false, length=30)
 private String code;
 @Column(name="classroom_name", nullable=false, length=100)
 private String classroomName;
 @Column(name="education_level", nullable=false, length=15)
 private String educationLevel;
 @Column(name="academic_year", nullable=false)
 private Integer academicYear;
 @Column(name="grade_id", nullable=false)
 private Long gradeId;
 @Column(name="section_id", nullable=false)
 private Long sectionId;
 @Column(name="capacity", nullable=false)
 private Integer capacity;
 @Column(name="teacher_id")
 private Integer teacherId;
 @Column(name="status", nullable=false, length=10)
 private String status;

 public Classroom() {}
 public Integer getClassroomId() { return classroomId; }
 public void setClassroomId(Integer classroomId) { this.classroomId = classroomId; }
 public String getCode() { return code; }
 public void setCode(String code) { this.code = code; }
 public String getClassroomName() { return classroomName; }
 public void setClassroomName(String classroomName) { this.classroomName = classroomName; }
 public String getEducationLevel() { return educationLevel; }
 public void setEducationLevel(String educationLevel) { this.educationLevel = educationLevel; }
 public Integer getAcademicYear() { return academicYear; }
 public void setAcademicYear(Integer academicYear) { this.academicYear = academicYear; }
 public Long getGradeId() { return gradeId; }
 public void setGradeId(Long gradeId) { this.gradeId = gradeId; }
 public Long getSectionId() { return sectionId; }
 public void setSectionId(Long sectionId) { this.sectionId = sectionId; }
 public Integer getCapacity() { return capacity; }
 public void setCapacity(Integer capacity) { this.capacity = capacity; }
 public Integer getTeacherId() { return teacherId; }
 public void setTeacherId(Integer teacherId) { this.teacherId = teacherId; }
 public String getStatus() { return status; }
 public void setStatus(String status) { this.status = status; }
}
