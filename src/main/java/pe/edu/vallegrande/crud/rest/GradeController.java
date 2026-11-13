package pe.edu.vallegrande.crud.rest;
import pe.edu.vallegrande.crud.model.Grade;
import pe.edu.vallegrande.crud.repository.GradeRepository;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;
@RestController
@RequestMapping("/api/grade")
@CrossOrigin(origins = "*")
public class GradeController {
 private final GradeRepository repository;
 public GradeController(GradeRepository repository) { this.repository = repository; }
 @GetMapping public List<Grade> listar() { return repository.findAll(); }
 @GetMapping("/{id}") public ResponseEntity<Grade> obtener(@PathVariable Long id) { return repository.findById(id).map(ResponseEntity::ok).orElseGet(() -> ResponseEntity.notFound().build()); }
 @PostMapping public Grade crear(@RequestBody Grade entidad) { entidad.setGradeId(null); return repository.save(entidad); }
 @PutMapping("/{id}") public ResponseEntity<Grade> actualizar(@PathVariable Long id, @RequestBody Grade entidad) { if (!repository.existsById(id)) return ResponseEntity.notFound().build(); entidad.setGradeId(id); return ResponseEntity.ok(repository.save(entidad)); }
 @DeleteMapping("/{id}") public ResponseEntity<Void> eliminar(@PathVariable Long id) { if (!repository.existsById(id)) return ResponseEntity.notFound().build(); repository.deleteById(id); return ResponseEntity.noContent().build(); }
}
