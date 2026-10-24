package pe.edu.vallegrande.crud.repository;
import pe.edu.vallegrande.crud.model.Section;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
@Repository
public interface SectionRepository extends JpaRepository<Section, Long> {
}
