package pe.edu.vallegrande.crud.rest;
import pe.edu.vallegrande.crud.model.CopyOfCourse;
import pe.edu.vallegrande.crud.repository.CopyOfCourseRepository;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;
@RestController
@RequestMapping("/api/copy-of-course")
@CrossOrigin(origins = "*")
public class CopyOfCourseController {
 private final CopyOfCourseRepository repository;
 public CopyOfCourseController(CopyOfCourseRepository repository) { this.repository = repository; }
 @GetMapping public List<CopyOfCourse> listar() { return repository.findAll(); }
 @GetMapping("/{id}") public ResponseEntity<CopyOfCourse> obtener(@PathVariable Integer id) { return repository.findById(id).map(ResponseEntity::ok).orElseGet(() -> ResponseEntity.notFound().build()); }
 @PostMapping public CopyOfCourse crear(@RequestBody CopyOfCourse entidad) { entidad.setCourseId(null); return repository.save(entidad); }
 @PutMapping("/{id}") public ResponseEntity<CopyOfCourse> actualizar(@PathVariable Integer id, @RequestBody CopyOfCourse entidad) { if (!repository.existsById(id)) return ResponseEntity.notFound().build(); entidad.setCourseId(id); return ResponseEntity.ok(repository.save(entidad)); }
 @DeleteMapping("/{id}") public ResponseEntity<Void> eliminar(@PathVariable Integer id) { if (!repository.existsById(id)) return ResponseEntity.notFound().build(); repository.deleteById(id); return ResponseEntity.noContent().build(); }
}
