package pe.edu.vallegrande.crud.service.impl;

import org.springframework.stereotype.Service;
import pe.edu.vallegrande.crud.model.AcademicPeriod;
import pe.edu.vallegrande.crud.repository.AcademicPeriodRepository;
import pe.edu.vallegrande.crud.service.AcademicPeriodService;

@Service
public class AcademicPeriodServiceImpl extends AbstractCrudService<AcademicPeriod, Integer> implements AcademicPeriodService {
    public AcademicPeriodServiceImpl(AcademicPeriodRepository repository) { super(repository); }
}
