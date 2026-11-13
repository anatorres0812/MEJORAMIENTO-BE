package pe.edu.vallegrande.crud.repository;
import org.springframework.data.jpa.repository.JpaRepository;
import pe.edu.vallegrande.crud.model.StudentGuardian;
public interface StudentGuardianRepository extends JpaRepository<StudentGuardian, StudentGuardianId> {}
