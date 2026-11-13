package pe.edu.vallegrande.crud.repository;
import pe.edu.vallegrande.crud.model.Attendance;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
@Repository
public interface AttendanceRepository extends JpaRepository<Attendance, Integer> {
}
