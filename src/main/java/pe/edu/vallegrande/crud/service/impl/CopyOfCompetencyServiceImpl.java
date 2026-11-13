package pe.edu.vallegrande.crud.service.impl;

import org.springframework.stereotype.Service;
import pe.edu.vallegrande.crud.model.CopyOfCompetency;
import pe.edu.vallegrande.crud.repository.CopyOfCompetencyRepository;
import pe.edu.vallegrande.crud.service.CopyOfCompetencyService;

@Service
public class CopyOfCompetencyServiceImpl extends AbstractCrudService<CopyOfCompetency, Integer> implements CopyOfCompetencyService {
    public CopyOfCompetencyServiceImpl(CopyOfCompetencyRepository repository) { super(repository); }
}
