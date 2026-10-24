package pe.edu.vallegrande.crud.repository;
import pe.edu.vallegrande.crud.model.CopyOfCurseGrade;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
@Repository
public interface CopyOfCurseGradeRepository extends JpaRepository<CopyOfCurseGrade, Integer> {
}
