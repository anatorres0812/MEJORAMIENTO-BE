package pe.edu.vallegrande.crud.repository;
import pe.edu.vallegrande.crud.model.CopyOfCourse;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
@Repository
public interface CopyOfCourseRepository extends JpaRepository<CopyOfCourse, Integer> {
}
