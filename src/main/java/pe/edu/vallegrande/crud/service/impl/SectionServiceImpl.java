package pe.edu.vallegrande.crud.service.impl;

import org.springframework.stereotype.Service;
import pe.edu.vallegrande.crud.model.Section;
import pe.edu.vallegrande.crud.repository.SectionRepository;
import pe.edu.vallegrande.crud.service.SectionService;

@Service
public class SectionServiceImpl extends AbstractCrudService<Section, Long> implements SectionService {
    public SectionServiceImpl(SectionRepository repository) { super(repository); }
}
