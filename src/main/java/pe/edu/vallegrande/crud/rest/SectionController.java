package pe.edu.vallegrande.crud.rest;
import pe.edu.vallegrande.crud.model.Section;
import pe.edu.vallegrande.crud.repository.SectionRepository;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;
@RestController
@RequestMapping("/api/section")
@CrossOrigin(origins = "*")
public class SectionController {
 private final SectionRepository repository;
 public SectionController(SectionRepository repository) { this.repository = repository; }
 @GetMapping public List<Section> listar() { return repository.findAll(); }
 @GetMapping("/{id}") public ResponseEntity<Section> obtener(@PathVariable Long id) { return repository.findById(id).map(ResponseEntity::ok).orElseGet(() -> ResponseEntity.notFound().build()); }
 @PostMapping public Section crear(@RequestBody Section entidad) { entidad.setSectionId(null); return repository.save(entidad); }
 @PutMapping("/{id}") public ResponseEntity<Section> actualizar(@PathVariable Long id, @RequestBody Section entidad) { if (!repository.existsById(id)) return ResponseEntity.notFound().build(); entidad.setSectionId(id); return ResponseEntity.ok(repository.save(entidad)); }
 @DeleteMapping("/{id}") public ResponseEntity<Void> eliminar(@PathVariable Long id) { if (!repository.existsById(id)) return ResponseEntity.notFound().build(); repository.deleteById(id); return ResponseEntity.noContent().build(); }
}
