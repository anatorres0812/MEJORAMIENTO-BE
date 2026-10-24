package pe.edu.vallegrande.crud.service.impl;

import org.springframework.stereotype.Service;
import pe.edu.vallegrande.crud.model.Enrollment;
import pe.edu.vallegrande.crud.repository.EnrollmentRepository;
import pe.edu.vallegrande.crud.service.EnrollmentService;

@Service
public class EnrollmentServiceImpl extends AbstractCrudService<Enrollment, Integer> implements EnrollmentService {
    public EnrollmentServiceImpl(EnrollmentRepository repository) { super(repository); }
}
