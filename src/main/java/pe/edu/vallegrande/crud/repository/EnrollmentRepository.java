package pe.edu.vallegrande.crud.repository;
import pe.edu.vallegrande.crud.model.Enrollment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
@Repository
public interface EnrollmentRepository extends JpaRepository<Enrollment, Integer> {
}
