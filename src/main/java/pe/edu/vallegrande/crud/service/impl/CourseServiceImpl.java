package pe.edu.vallegrande.crud.service.impl;

import org.springframework.stereotype.Service;
import pe.edu.vallegrande.crud.model.Course;
import pe.edu.vallegrande.crud.repository.CourseRepository;
import pe.edu.vallegrande.crud.service.CourseService;

@Service
public class CourseServiceImpl extends AbstractCrudService<Course, Integer> implements CourseService {
    public CourseServiceImpl(CourseRepository repository) { super(repository); }
}
