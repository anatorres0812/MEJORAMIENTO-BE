package pe.edu.vallegrande.crud.rest;
import pe.edu.vallegrande.crud.model.Classroom;
import pe.edu.vallegrande.crud.repository.ClassroomRepository;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;
@RestController
@RequestMapping("/api/classroom")
@CrossOrigin(origins = "*")
public class ClassroomController {
 private final ClassroomRepository repository;
 public ClassroomController(ClassroomRepository repository) { this.repository = repository; }
 @GetMapping public List<Classroom> listar() { return repository.findAll(); }
 @GetMapping("/{id}") public ResponseEntity<Classroom> obtener(@PathVariable Integer id) { return repository.findById(id).map(ResponseEntity::ok).orElseGet(() -> ResponseEntity.notFound().build()); }
 @PostMapping public Classroom crear(@RequestBody Classroom entidad) { entidad.setClassroomId(null); return repository.save(entidad); }
 @PutMapping("/{id}") public ResponseEntity<Classroom> actualizar(@PathVariable Integer id, @RequestBody Classroom entidad) { if (!repository.existsById(id)) return ResponseEntity.notFound().build(); entidad.setClassroomId(id); return ResponseEntity.ok(repository.save(entidad)); }
 @DeleteMapping("/{id}") public ResponseEntity<Void> eliminar(@PathVariable Integer id) { if (!repository.existsById(id)) return ResponseEntity.notFound().build(); repository.deleteById(id); return ResponseEntity.noContent().build(); }
}
