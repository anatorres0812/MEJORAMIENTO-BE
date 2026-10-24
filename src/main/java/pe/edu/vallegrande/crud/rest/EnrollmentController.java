package pe.edu.vallegrande.crud.rest;
import pe.edu.vallegrande.crud.model.Enrollment;
import pe.edu.vallegrande.crud.repository.EnrollmentRepository;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;
@RestController
@RequestMapping("/api/enrollment")
@CrossOrigin(origins = "*")
public class EnrollmentController {
 private final EnrollmentRepository repository;
 public EnrollmentController(EnrollmentRepository repository) { this.repository = repository; }
 @GetMapping public List<Enrollment> listar() { return repository.findAll(); }
 @GetMapping("/{id}") public ResponseEntity<Enrollment> obtener(@PathVariable Integer id) { return repository.findById(id).map(ResponseEntity::ok).orElseGet(() -> ResponseEntity.notFound().build()); }
 @PostMapping public Enrollment crear(@RequestBody Enrollment entidad) { entidad.setEnrollmentId(null); return repository.save(entidad); }
 @PutMapping("/{id}") public ResponseEntity<Enrollment> actualizar(@PathVariable Integer id, @RequestBody Enrollment entidad) { if (!repository.existsById(id)) return ResponseEntity.notFound().build(); entidad.setEnrollmentId(id); return ResponseEntity.ok(repository.save(entidad)); }
 @DeleteMapping("/{id}") public ResponseEntity<Void> eliminar(@PathVariable Integer id) { if (!repository.existsById(id)) return ResponseEntity.notFound().build(); repository.deleteById(id); return ResponseEntity.noContent().build(); }
}
