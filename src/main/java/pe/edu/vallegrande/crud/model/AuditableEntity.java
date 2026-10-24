package pe.edu.vallegrande.crud.model;
import jakarta.persistence.Column;
import jakarta.persistence.MappedSuperclass;
import java.time.LocalDateTime;
@MappedSuperclass
public abstract class AuditableEntity {
 @Column(name="created_at", insertable=false, updatable=false) private LocalDateTime createdAt;
 @Column(name="updated_at", insertable=false, updatable=false) private LocalDateTime updatedAt;
 @Column(name="created_by", insertable=false, updatable=false) private String createdBy;
 @Column(name="updated_by", insertable=false, updatable=false) private String updatedBy;
 public LocalDateTime getCreatedAt(){return createdAt;} public LocalDateTime getUpdatedAt(){return updatedAt;}
 public String getCreatedBy(){return createdBy;} public String getUpdatedBy(){return updatedBy;}
}
