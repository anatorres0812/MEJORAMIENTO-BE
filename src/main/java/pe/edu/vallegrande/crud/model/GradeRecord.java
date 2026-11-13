package pe.edu.vallegrande.crud.model;

import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name="grade_record", schema="dbo")
public class GradeRecord extends AuditableEntity {
 @Id
 @GeneratedValue(strategy=GenerationType.IDENTITY)
 @Column(name="grade_record_id")
 private Integer gradeRecordId;
 @Column(name="enrollment_id", nullable=false)
 private Integer enrollmentId;
 @Column(name="competency_id", nullable=false)
 private Integer competencyId;
 @Column(name="course_id", nullable=false)
 private Integer courseId;
 @Column(name="academic_period_id", nullable=false)
 private Integer academicPeriodId;
 @Column(name="teacher_id", nullable=false)
 private Integer teacherId;
 @Column(name="grade_values", nullable=false, length=5)
 private String gradeValues;
 @Column(name="observation", length=500)
 private String observation;
 @Column(name="recorded_date", nullable=false)
 private LocalDate recordedDate;
 @Column(name="status", nullable=false, length=10)
 private String status;

 public GradeRecord() {}
 public Integer getGradeRecordId() { return gradeRecordId; }
 public void setGradeRecordId(Integer gradeRecordId) { this.gradeRecordId = gradeRecordId; }
 public Integer getEnrollmentId() { return enrollmentId; }
 public void setEnrollmentId(Integer enrollmentId) { this.enrollmentId = enrollmentId; }
 public Integer getCompetencyId() { return competencyId; }
 public void setCompetencyId(Integer competencyId) { this.competencyId = competencyId; }
 public Integer getCourseId() { return courseId; }
 public void setCourseId(Integer courseId) { this.courseId = courseId; }
 public Integer getAcademicPeriodId() { return academicPeriodId; }
 public void setAcademicPeriodId(Integer academicPeriodId) { this.academicPeriodId = academicPeriodId; }
 public Integer getTeacherId() { return teacherId; }
 public void setTeacherId(Integer teacherId) { this.teacherId = teacherId; }
 public String getGradeValues() { return gradeValues; }
 public void setGradeValues(String gradeValues) { this.gradeValues = gradeValues; }
 public String getObservation() { return observation; }
 public void setObservation(String observation) { this.observation = observation; }
 public LocalDate getRecordedDate() { return recordedDate; }
 public void setRecordedDate(LocalDate recordedDate) { this.recordedDate = recordedDate; }
 public String getStatus() { return status; }
 public void setStatus(String status) { this.status = status; }
}
