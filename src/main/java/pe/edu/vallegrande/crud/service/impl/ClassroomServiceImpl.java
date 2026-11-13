package pe.edu.vallegrande.crud.service.impl;

import org.springframework.stereotype.Service;
import pe.edu.vallegrande.crud.model.Classroom;
import pe.edu.vallegrande.crud.repository.ClassroomRepository;
import pe.edu.vallegrande.crud.service.ClassroomService;

@Service
public class ClassroomServiceImpl extends AbstractCrudService<Classroom, Integer> implements ClassroomService {
    public ClassroomServiceImpl(ClassroomRepository repository) { super(repository); }
}
