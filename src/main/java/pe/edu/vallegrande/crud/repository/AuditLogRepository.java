package pe.edu.vallegrande.crud.repository;
import pe.edu.vallegrande.crud.model.AuditLog;
import org.springframework.data.jpa.repository.JpaRepository;
public interface AuditLogRepository extends JpaRepository<AuditLog, Long> {}
