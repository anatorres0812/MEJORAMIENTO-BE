package pe.edu.vallegrande.crud.rest;
import pe.edu.vallegrande.crud.model.GradeRecord;
import pe.edu.vallegrande.crud.repository.GradeRecordRepository;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;
@RestController
@RequestMapping("/api/grade-record")
@CrossOrigin(origins = "*")
public class GradeRecordController {
 private final GradeRecordRepository repository;
 public GradeRecordController(GradeRecordRepository repository) { this.repository = repository; }
 @GetMapping public List<GradeRecord> listar() { return repository.findAll(); }
 @GetMapping("/{id}") public ResponseEntity<GradeRecord> obtener(@PathVariable Integer id) { return repository.findById(id).map(ResponseEntity::ok).orElseGet(() -> ResponseEntity.notFound().build()); }
 @PostMapping public GradeRecord crear(@RequestBody GradeRecord entidad) { entidad.setGradeRecordId(null); return repository.save(entidad); }
 @PutMapping("/{id}") public ResponseEntity<GradeRecord> actualizar(@PathVariable Integer id, @RequestBody GradeRecord entidad) { if (!repository.existsById(id)) return ResponseEntity.notFound().build(); entidad.setGradeRecordId(id); return ResponseEntity.ok(repository.save(entidad)); }
 @DeleteMapping("/{id}") public ResponseEntity<Void> eliminar(@PathVariable Integer id) { if (!repository.existsById(id)) return ResponseEntity.notFound().build(); repository.deleteById(id); return ResponseEntity.noContent().build(); }
}
