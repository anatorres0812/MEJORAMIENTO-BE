package pe.edu.vallegrande.crud.rest;
import pe.edu.vallegrande.crud.model.CopyOfCurseGrade;
import pe.edu.vallegrande.crud.repository.CopyOfCurseGradeRepository;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;
@RestController
@RequestMapping("/api/copy-of-curse--grade")
@CrossOrigin(origins = "*")
public class CopyOfCurseGradeController {
 private final CopyOfCurseGradeRepository repository;
 public CopyOfCurseGradeController(CopyOfCurseGradeRepository repository) { this.repository = repository; }
 @GetMapping public List<CopyOfCurseGrade> listar() { return repository.findAll(); }
 @GetMapping("/{id}") public ResponseEntity<CopyOfCurseGrade> obtener(@PathVariable Integer id) { return repository.findById(id).map(ResponseEntity::ok).orElseGet(() -> ResponseEntity.notFound().build()); }
 @PostMapping public CopyOfCurseGrade crear(@RequestBody CopyOfCurseGrade entidad) { entidad.setCurseId(null); return repository.save(entidad); }
 @PutMapping("/{id}") public ResponseEntity<CopyOfCurseGrade> actualizar(@PathVariable Integer id, @RequestBody CopyOfCurseGrade entidad) { if (!repository.existsById(id)) return ResponseEntity.notFound().build(); entidad.setCurseId(id); return ResponseEntity.ok(repository.save(entidad)); }
 @DeleteMapping("/{id}") public ResponseEntity<Void> eliminar(@PathVariable Integer id) { if (!repository.existsById(id)) return ResponseEntity.notFound().build(); repository.deleteById(id); return ResponseEntity.noContent().build(); }
}
