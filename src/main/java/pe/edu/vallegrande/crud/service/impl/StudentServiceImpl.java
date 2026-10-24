package pe.edu.vallegrande.crud.service.impl;

import org.springframework.stereotype.Service;
import pe.edu.vallegrande.crud.model.Student;
import pe.edu.vallegrande.crud.repository.StudentRepository;
import pe.edu.vallegrande.crud.service.StudentService;

@Service
public class StudentServiceImpl extends AbstractCrudService<Student, Integer> implements StudentService {
    public StudentServiceImpl(StudentRepository repository) { super(repository); }
}
