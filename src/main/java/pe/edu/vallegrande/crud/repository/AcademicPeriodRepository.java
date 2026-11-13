package pe.edu.vallegrande.crud.repository;
import pe.edu.vallegrande.crud.model.AcademicPeriod;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
@Repository
public interface AcademicPeriodRepository extends JpaRepository<AcademicPeriod, Integer> {
}
