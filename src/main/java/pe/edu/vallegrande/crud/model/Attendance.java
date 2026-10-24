package pe.edu.vallegrande.crud.model;

import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name="attendance", schema="dbo")
public class Attendance extends AuditableEntity {
 @Id
 @GeneratedValue(strategy=GenerationType.IDENTITY)
 @Column(name="attendance_id")
 private Integer attendanceId;
 @Column(name="enrollment_id", nullable=false)
 private Integer enrollmentId;
 @Column(name="course_id", nullable=false)
 private Integer courseId;
 @Column(name="academic_period_id", nullable=false)
 private Integer academicPeriodId;
 @Column(name="teacher_id", nullable=false)
 private Integer teacherId;
 @Column(name="attendance_date", nullable=false)
 private LocalDate attendanceDate;
 @Column(name="attendance_status", nullable=false, length=15)
 private String attendanceStatus;
 @Column(name="observation", length=500)
 private String observation;
 @Column(name="status", nullable=false, length=10)
 private String status;

 public Attendance() {}
 public Integer getAttendanceId() { return attendanceId; }
 public void setAttendanceId(Integer attendanceId) { this.attendanceId = attendanceId; }
 public Integer getEnrollmentId() { return enrollmentId; }
 public void setEnrollmentId(Integer enrollmentId) { this.enrollmentId = enrollmentId; }
 public Integer getCourseId() { return courseId; }
 public void setCourseId(Integer courseId) { this.courseId = courseId; }
 public Integer getAcademicPeriodId() { return academicPeriodId; }
 public void setAcademicPeriodId(Integer academicPeriodId) { this.academicPeriodId = academicPeriodId; }
 public Integer getTeacherId() { return teacherId; }
 public void setTeacherId(Integer teacherId) { this.teacherId = teacherId; }
 public LocalDate getAttendanceDate() { return attendanceDate; }
 public void setAttendanceDate(LocalDate attendanceDate) { this.attendanceDate = attendanceDate; }
 public String getAttendanceStatus() { return attendanceStatus; }
 public void setAttendanceStatus(String attendanceStatus) { this.attendanceStatus = attendanceStatus; }
 public String getObservation() { return observation; }
 public void setObservation(String observation) { this.observation = observation; }
 public String getStatus() { return status; }
 public void setStatus(String status) { this.status = status; }
}
