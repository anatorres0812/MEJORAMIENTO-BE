package pe.edu.vallegrande.crud.repository;
import org.springframework.data.jpa.repository.JpaRepository;
import pe.edu.vallegrande.crud.model.Assessment;
public interface AssessmentRepository extends JpaRepository<Assessment, Integer> {}
