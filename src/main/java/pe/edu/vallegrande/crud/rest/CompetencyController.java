package pe.edu.vallegrande.crud.rest;
import pe.edu.vallegrande.crud.model.Competency;
import pe.edu.vallegrande.crud.repository.CompetencyRepository;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;
@RestController
@RequestMapping("/api/competency")
@CrossOrigin(origins = "*")
public class CompetencyController {
 private final CompetencyRepository repository;
 public CompetencyController(CompetencyRepository repository) { this.repository = repository; }
 @GetMapping public List<Competency> listar() { return repository.findAll(); }
 @GetMapping("/{id}") public ResponseEntity<Competency> obtener(@PathVariable Integer id) { return repository.findById(id).map(ResponseEntity::ok).orElseGet(() -> ResponseEntity.notFound().build()); }
 @PostMapping public Competency crear(@RequestBody Competency entidad) { entidad.setCompetencyId(null); return repository.save(entidad); }
 @PutMapping("/{id}") public ResponseEntity<Competency> actualizar(@PathVariable Integer id, @RequestBody Competency entidad) { if (!repository.existsById(id)) return ResponseEntity.notFound().build(); entidad.setCompetencyId(id); return ResponseEntity.ok(repository.save(entidad)); }
 @DeleteMapping("/{id}") public ResponseEntity<Void> eliminar(@PathVariable Integer id) { if (!repository.existsById(id)) return ResponseEntity.notFound().build(); repository.deleteById(id); return ResponseEntity.noContent().build(); }
}
