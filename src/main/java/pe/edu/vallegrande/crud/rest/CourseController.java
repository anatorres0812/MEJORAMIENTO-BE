package pe.edu.vallegrande.crud.rest;
import pe.edu.vallegrande.crud.model.Course;
import pe.edu.vallegrande.crud.repository.CourseRepository;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;
@RestController
@RequestMapping("/api/course")
@CrossOrigin(origins = "*")
public class CourseController {
 private final CourseRepository repository;
 public CourseController(CourseRepository repository) { this.repository = repository; }
 @GetMapping public List<Course> listar() { return repository.findAll(); }
 @GetMapping("/{id}") public ResponseEntity<Course> obtener(@PathVariable Integer id) { return repository.findById(id).map(ResponseEntity::ok).orElseGet(() -> ResponseEntity.notFound().build()); }
 @PostMapping public Course crear(@RequestBody Course entidad) { entidad.setCourseId(null); return repository.save(entidad); }
 @PutMapping("/{id}") public ResponseEntity<Course> actualizar(@PathVariable Integer id, @RequestBody Course entidad) { if (!repository.existsById(id)) return ResponseEntity.notFound().build(); entidad.setCourseId(id); return ResponseEntity.ok(repository.save(entidad)); }
 @DeleteMapping("/{id}") public ResponseEntity<Void> eliminar(@PathVariable Integer id) { if (!repository.existsById(id)) return ResponseEntity.notFound().build(); repository.deleteById(id); return ResponseEntity.noContent().build(); }
}
