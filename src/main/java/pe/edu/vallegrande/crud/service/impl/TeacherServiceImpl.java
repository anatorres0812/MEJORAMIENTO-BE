package pe.edu.vallegrande.crud.service.impl;

import org.springframework.stereotype.Service;
import pe.edu.vallegrande.crud.model.Teacher;
import pe.edu.vallegrande.crud.repository.TeacherRepository;
import pe.edu.vallegrande.crud.service.TeacherService;

@Service
public class TeacherServiceImpl extends AbstractCrudService<Teacher, Integer> implements TeacherService {
    public TeacherServiceImpl(TeacherRepository repository) { super(repository); }
}
