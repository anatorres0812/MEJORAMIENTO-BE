package pe.edu.vallegrande.crud.service.impl;

import org.springframework.stereotype.Service;
import pe.edu.vallegrande.crud.model.CopyOfCurseGrade;
import pe.edu.vallegrande.crud.repository.CopyOfCurseGradeRepository;
import pe.edu.vallegrande.crud.service.CopyOfCurseGradeService;

@Service
public class CopyOfCurseGradeServiceImpl extends AbstractCrudService<CopyOfCurseGrade, Integer> implements CopyOfCurseGradeService {
    public CopyOfCurseGradeServiceImpl(CopyOfCurseGradeRepository repository) { super(repository); }
}
