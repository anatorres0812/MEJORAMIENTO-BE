package pe.edu.vallegrande.crud.repository;
import org.springframework.data.jpa.repository.JpaRepository;
import pe.edu.vallegrande.crud.model.Guardian;
public interface GuardianRepository extends JpaRepository<Guardian, Integer> {}
