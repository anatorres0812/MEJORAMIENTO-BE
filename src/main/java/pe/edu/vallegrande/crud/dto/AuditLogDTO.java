
package pe.edu.vallegrande.crud.dto;

import java.time.LocalDateTime;

public class AuditLogDTO {
    private Long auditId;
    private String tableName;
    private String recordId;
    private String operation;
    private String changedBy;
    private LocalDateTime changedAt;
    private String oldValues;
    private String newValues;

    public AuditLogDTO() {}

    public Long getAuditId() { return auditId; }
    public void setAuditId(Long v) { auditId = v; }
    public String getTableName() { return tableName; }
    public void setTableName(String v) { tableName = v; }
    public String getRecordId() { return recordId; }
    public void setRecordId(String v) { recordId = v; }
    public String getOperation() { return operation; }
    public void setOperation(String v) { operation = v; }
    public String getChangedBy() { return changedBy; }
    public void setChangedBy(String v) { changedBy = v; }
    public LocalDateTime getChangedAt() { return changedAt; }
    public void setChangedAt(LocalDateTime v) { changedAt = v; }
    public String getOldValues() { return oldValues; }
    public void setOldValues(String v) { oldValues = v; }
    public String getNewValues() { return newValues; }
    public void setNewValues(String v) { newValues = v; }
}
