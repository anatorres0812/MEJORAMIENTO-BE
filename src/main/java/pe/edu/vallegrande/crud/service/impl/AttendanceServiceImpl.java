package pe.edu.vallegrande.crud.service.impl;

import org.springframework.stereotype.Service;
import pe.edu.vallegrande.crud.model.Attendance;
import pe.edu.vallegrande.crud.repository.AttendanceRepository;
import pe.edu.vallegrande.crud.service.AttendanceService;

@Service
public class AttendanceServiceImpl extends AbstractCrudService<Attendance, Integer> implements AttendanceService {
    public AttendanceServiceImpl(AttendanceRepository repository) { super(repository); }
}
