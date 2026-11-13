package pe.edu.vallegrande.crud.rest;
import pe.edu.vallegrande.crud.model.Student;
import pe.edu.vallegrande.crud.repository.StudentRepository;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;
@RestController
@RequestMapping("/api/student")
@CrossOrigin(origins = "*")
public class StudentController {
 private final StudentRepository repository;
 public StudentController(StudentRepository repository) { this.repository = repository; }
 @GetMapping public List<Student> listar() { return repository.findAll(); }
 @GetMapping("/{id}") public ResponseEntity<Student> obtener(@PathVariable Integer id) { return repository.findById(id).map(ResponseEntity::ok).orElseGet(() -> ResponseEntity.notFound().build()); }
 @PostMapping public Student crear(@RequestBody Student entidad) { entidad.setStudentId(null); return repository.save(entidad); }
 @PutMapping("/{id}") public ResponseEntity<Student> actualizar(@PathVariable Integer id, @RequestBody Student entidad) { if (!repository.existsById(id)) return ResponseEntity.notFound().build(); entidad.setStudentId(id); return ResponseEntity.ok(repository.save(entidad)); }
 @DeleteMapping("/{id}") public ResponseEntity<Void> eliminar(@PathVariable Integer id) { if (!repository.existsById(id)) return ResponseEntity.notFound().build(); repository.deleteById(id); return ResponseEntity.noContent().build(); }
}
