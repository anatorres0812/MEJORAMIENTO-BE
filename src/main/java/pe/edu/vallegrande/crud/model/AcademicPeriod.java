package pe.edu.vallegrande.crud.model;

import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name="academic_period", schema="dbo")
public class AcademicPeriod extends AuditableEntity {
 @Id
 @GeneratedValue(strategy=GenerationType.IDENTITY)
 @Column(name="academic_period_id")
 private Integer academicPeriodId;
 @Column(name="period_name", nullable=false, length=100)
 private String periodName;
 @Column(name="academic_year", nullable=false)
 private Integer academicYear;
 @Column(name="start_date", nullable=false)
 private LocalDate startDate;
 @Column(name="end_date", nullable=false)
 private LocalDate endDate;
 @Column(name="is_active", nullable=false)
 private Boolean isActive;
 @Column(name="status", nullable=false, length=10)
 private String status;

 public AcademicPeriod() {}
 public Integer getAcademicPeriodId() { return academicPeriodId; }
 public void setAcademicPeriodId(Integer academicPeriodId) { this.academicPeriodId = academicPeriodId; }
 public String getPeriodName() { return periodName; }
 public void setPeriodName(String periodName) { this.periodName = periodName; }
 public Integer getAcademicYear() { return academicYear; }
 public void setAcademicYear(Integer academicYear) { this.academicYear = academicYear; }
 public LocalDate getStartDate() { return startDate; }
 public void setStartDate(LocalDate startDate) { this.startDate = startDate; }
 public LocalDate getEndDate() { return endDate; }
 public void setEndDate(LocalDate endDate) { this.endDate = endDate; }
 public Boolean getIsActive() { return isActive; }
 public void setIsActive(Boolean isActive) { this.isActive = isActive; }
 public String getStatus() { return status; }
 public void setStatus(String status) { this.status = status; }
}
