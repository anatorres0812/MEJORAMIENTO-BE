package pe.edu.vallegrande.crud.service.impl;

import org.springframework.stereotype.Service;
import pe.edu.vallegrande.crud.model.AuditLog;
import pe.edu.vallegrande.crud.repository.AuditLogRepository;
import pe.edu.vallegrande.crud.service.AuditLogService;

@Service
public class AuditLogServiceImpl extends AbstractCrudService<AuditLog, Long> implements AuditLogService {
    public AuditLogServiceImpl(AuditLogRepository repository) { super(repository); }
}
