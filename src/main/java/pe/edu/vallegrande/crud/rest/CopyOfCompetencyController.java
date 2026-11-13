package pe.edu.vallegrande.crud.rest;
import pe.edu.vallegrande.crud.model.CopyOfCompetency;
import pe.edu.vallegrande.crud.repository.CopyOfCompetencyRepository;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;
@RestController
@RequestMapping("/api/copy-of-competency")
@CrossOrigin(origins = "*")
public class CopyOfCompetencyController {
 private final CopyOfCompetencyRepository repository;
 public CopyOfCompetencyController(CopyOfCompetencyRepository repository) { this.repository = repository; }
 @GetMapping public List<CopyOfCompetency> listar() { return repository.findAll(); }
 @GetMapping("/{id}") public ResponseEntity<CopyOfCompetency> obtener(@PathVariable Integer id) { return repository.findById(id).map(ResponseEntity::ok).orElseGet(() -> ResponseEntity.notFound().build()); }
 @PostMapping public CopyOfCompetency crear(@RequestBody CopyOfCompetency entidad) { entidad.setCompetencyId(null); return repository.save(entidad); }
 @PutMapping("/{id}") public ResponseEntity<CopyOfCompetency> actualizar(@PathVariable Integer id, @RequestBody CopyOfCompetency entidad) { if (!repository.existsById(id)) return ResponseEntity.notFound().build(); entidad.setCompetencyId(id); return ResponseEntity.ok(repository.save(entidad)); }
 @DeleteMapping("/{id}") public ResponseEntity<Void> eliminar(@PathVariable Integer id) { if (!repository.existsById(id)) return ResponseEntity.notFound().build(); repository.deleteById(id); return ResponseEntity.noContent().build(); }
}
