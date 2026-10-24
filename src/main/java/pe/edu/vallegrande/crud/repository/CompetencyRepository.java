package pe.edu.vallegrande.crud.repository;
import pe.edu.vallegrande.crud.model.Competency;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
@Repository
public interface CompetencyRepository extends JpaRepository<Competency, Integer> {
}
