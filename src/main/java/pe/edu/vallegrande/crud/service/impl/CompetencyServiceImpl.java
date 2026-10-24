package pe.edu.vallegrande.crud.service.impl;

import org.springframework.stereotype.Service;
import pe.edu.vallegrande.crud.model.Competency;
import pe.edu.vallegrande.crud.repository.CompetencyRepository;
import pe.edu.vallegrande.crud.service.CompetencyService;

@Service
public class CompetencyServiceImpl extends AbstractCrudService<Competency, Integer> implements CompetencyService {
    public CompetencyServiceImpl(CompetencyRepository repository) { super(repository); }
}
