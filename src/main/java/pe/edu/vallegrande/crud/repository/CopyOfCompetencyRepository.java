package pe.edu.vallegrande.crud.repository;
import pe.edu.vallegrande.crud.model.CopyOfCompetency;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
@Repository
public interface CopyOfCompetencyRepository extends JpaRepository<CopyOfCompetency, Integer> {
}
