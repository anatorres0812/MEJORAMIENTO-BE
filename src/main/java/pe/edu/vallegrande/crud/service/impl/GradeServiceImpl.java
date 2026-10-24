package pe.edu.vallegrande.crud.service.impl;

import org.springframework.stereotype.Service;
import pe.edu.vallegrande.crud.model.Grade;
import pe.edu.vallegrande.crud.repository.GradeRepository;
import pe.edu.vallegrande.crud.service.GradeService;

@Service
public class GradeServiceImpl extends AbstractCrudService<Grade, Long> implements GradeService {
    public GradeServiceImpl(GradeRepository repository) { super(repository); }
}
