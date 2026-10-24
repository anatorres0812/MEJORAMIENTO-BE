package pe.edu.vallegrande.crud.repository;
import pe.edu.vallegrande.crud.model.GradeRecord;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
@Repository
public interface GradeRecordRepository extends JpaRepository<GradeRecord, Integer> {
}
