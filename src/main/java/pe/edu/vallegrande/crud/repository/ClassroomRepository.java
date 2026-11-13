package pe.edu.vallegrande.crud.repository;
import pe.edu.vallegrande.crud.model.Classroom;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
@Repository
public interface ClassroomRepository extends JpaRepository<Classroom, Integer> {
}
