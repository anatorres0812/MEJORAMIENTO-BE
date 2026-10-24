package pe.edu.vallegrande.crud.model;
import jakarta.persistence.*;
import java.time.LocalDateTime;
@Entity @Table(name="audit_log", schema="dbo")
public class AuditLog {
 @Id @GeneratedValue(strategy=GenerationType.IDENTITY) @Column(name="audit_log_id") private Long auditLogId;
 @Column(name="table_name", nullable=false) private String tableName;
 @Column(name="operation_type", nullable=false) private String operationType;
 @Column(name="record_key") private String recordKey;
 @Column(name="changed_at", nullable=false) private LocalDateTime changedAt;
 @Column(name="changed_by", nullable=false) private String changedBy;
 @Column(name="details") private String details;
 public AuditLog() {}
 public Long getAuditLogId(){return auditLogId;} public String getTableName(){return tableName;} public String getOperationType(){return operationType;} public String getRecordKey(){return recordKey;} public LocalDateTime getChangedAt(){return changedAt;} public String getChangedBy(){return changedBy;} public String getDetails(){return details;}
 public void setAuditLogId(Long v){auditLogId=v;} public void setTableName(String v){tableName=v;} public void setOperationType(String v){operationType=v;} public void setRecordKey(String v){recordKey=v;} public void setChangedAt(LocalDateTime v){changedAt=v;} public void setChangedBy(String v){changedBy=v;} public void setDetails(String v){details=v;}
}
