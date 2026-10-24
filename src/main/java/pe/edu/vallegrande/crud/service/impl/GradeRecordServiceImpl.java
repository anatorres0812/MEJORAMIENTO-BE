package pe.edu.vallegrande.crud.service.impl;

import org.springframework.stereotype.Service;
import pe.edu.vallegrande.crud.model.GradeRecord;
import pe.edu.vallegrande.crud.repository.GradeRecordRepository;
import pe.edu.vallegrande.crud.service.GradeRecordService;

@Service
public class GradeRecordServiceImpl extends AbstractCrudService<GradeRecord, Integer> implements GradeRecordService {
    public GradeRecordServiceImpl(GradeRecordRepository repository) { super(repository); }
}
