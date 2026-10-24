package pe.edu.vallegrande.crud.model;

import jakarta.persistence.*;

@Entity
@Table(name="Copy_of_curse__grade", schema="dbo")
public class CopyOfCurseGrade extends AuditableEntity {
 @Id
 @GeneratedValue(strategy=GenerationType.IDENTITY)
 @Column(name="curse_id")
 private Integer curseId;
 @Column(name="grade_id", nullable=false)
 private Long gradeId;
 @Column(name="course_id", nullable=false)
 private Integer courseId;

 public CopyOfCurseGrade() {}
 public Integer getCurseId() { return curseId; }
 public void setCurseId(Integer curseId) { this.curseId = curseId; }
 public Long getGradeId() { return gradeId; }
 public void setGradeId(Long gradeId) { this.gradeId = gradeId; }
 public Integer getCourseId() { return courseId; }
 public void setCourseId(Integer courseId) { this.courseId = courseId; }
}
