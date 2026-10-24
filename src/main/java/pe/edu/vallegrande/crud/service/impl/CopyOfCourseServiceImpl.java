package pe.edu.vallegrande.crud.service.impl;

import org.springframework.stereotype.Service;
import pe.edu.vallegrande.crud.model.CopyOfCourse;
import pe.edu.vallegrande.crud.repository.CopyOfCourseRepository;
import pe.edu.vallegrande.crud.service.CopyOfCourseService;

@Service
public class CopyOfCourseServiceImpl extends AbstractCrudService<CopyOfCourse, Integer> implements CopyOfCourseService {
    public CopyOfCourseServiceImpl(CopyOfCourseRepository repository) { super(repository); }
}
