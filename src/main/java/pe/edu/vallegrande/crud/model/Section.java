package pe.edu.vallegrande.crud.model;

import jakarta.persistence.*;

@Entity
@Table(name="section", schema="dbo")
public class Section extends AuditableEntity {
 @Id
 @GeneratedValue(strategy=GenerationType.IDENTITY)
 @Column(name="section_id")
 private Long sectionId;
 @Column(name="section_name", nullable=false, length=50)
 private String sectionName;
 @Column(name="capacity", nullable=false)
 private Integer capacity;
 @Column(name="shift", nullable=false, length=10)
 private String shift;
 @Column(name="status", nullable=false, length=10)
 private String status;

 public Section() {}
 public Long getSectionId() { return sectionId; }
 public void setSectionId(Long sectionId) { this.sectionId = sectionId; }
 public String getSectionName() { return sectionName; }
 public void setSectionName(String sectionName) { this.sectionName = sectionName; }
 public Integer getCapacity() { return capacity; }
 public void setCapacity(Integer capacity) { this.capacity = capacity; }
 public String getShift() { return shift; }
 public void setShift(String shift) { this.shift = shift; }
 public String getStatus() { return status; }
 public void setStatus(String status) { this.status = status; }
}
