package pe.edu.vallegrande.crud.repository;
import pe.edu.vallegrande.crud.model.Grade;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
@Repository
public interface GradeRepository extends JpaRepository<Grade, Long> {
}
