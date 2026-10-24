package pe.edu.vallegrande.crud.rest;
import pe.edu.vallegrande.crud.model.Teacher;
import pe.edu.vallegrande.crud.repository.TeacherRepository;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;
@RestController
@RequestMapping("/api/teacher")
@CrossOrigin(origins = "*")
public class TeacherController {
 private final TeacherRepository repository;
 public TeacherController(TeacherRepository repository) { this.repository = repository; }
 @GetMapping public List<Teacher> listar() { return repository.findAll(); }
 @GetMapping("/{id}") public ResponseEntity<Teacher> obtener(@PathVariable Integer id) { return repository.findById(id).map(ResponseEntity::ok).orElseGet(() -> ResponseEntity.notFound().build()); }
 @PostMapping public Teacher crear(@RequestBody Teacher entidad) { entidad.setTeacherId(null); return repository.save(entidad); }
 @PutMapping("/{id}") public ResponseEntity<Teacher> actualizar(@PathVariable Integer id, @RequestBody Teacher entidad) { if (!repository.existsById(id)) return ResponseEntity.notFound().build(); entidad.setTeacherId(id); return ResponseEntity.ok(repository.save(entidad)); }
 @DeleteMapping("/{id}") public ResponseEntity<Void> eliminar(@PathVariable Integer id) { if (!repository.existsById(id)) return ResponseEntity.notFound().build(); repository.deleteById(id); return ResponseEntity.noContent().build(); }
}
