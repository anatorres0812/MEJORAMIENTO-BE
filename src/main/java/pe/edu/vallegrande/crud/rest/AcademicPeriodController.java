package pe.edu.vallegrande.crud.rest;
import pe.edu.vallegrande.crud.model.AcademicPeriod;
import pe.edu.vallegrande.crud.repository.AcademicPeriodRepository;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;
@RestController
@RequestMapping("/api/academic-period")
@CrossOrigin(origins = "*")
public class AcademicPeriodController {
 private final AcademicPeriodRepository repository;
 public AcademicPeriodController(AcademicPeriodRepository repository) { this.repository = repository; }
 @GetMapping public List<AcademicPeriod> listar() { return repository.findAll(); }
 @GetMapping("/{id}") public ResponseEntity<AcademicPeriod> obtener(@PathVariable Integer id) { return repository.findById(id).map(ResponseEntity::ok).orElseGet(() -> ResponseEntity.notFound().build()); }
 @PostMapping public AcademicPeriod crear(@RequestBody AcademicPeriod entidad) { entidad.setAcademicPeriodId(null); return repository.save(entidad); }
 @PutMapping("/{id}") public ResponseEntity<AcademicPeriod> actualizar(@PathVariable Integer id, @RequestBody AcademicPeriod entidad) { if (!repository.existsById(id)) return ResponseEntity.notFound().build(); entidad.setAcademicPeriodId(id); return ResponseEntity.ok(repository.save(entidad)); }
 @DeleteMapping("/{id}") public ResponseEntity<Void> eliminar(@PathVariable Integer id) { if (!repository.existsById(id)) return ResponseEntity.notFound().build(); repository.deleteById(id); return ResponseEntity.noContent().build(); }
}
