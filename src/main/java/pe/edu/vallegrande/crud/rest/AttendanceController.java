package pe.edu.vallegrande.crud.rest;
import pe.edu.vallegrande.crud.model.Attendance;
import pe.edu.vallegrande.crud.repository.AttendanceRepository;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;
@RestController
@RequestMapping("/api/attendance")
@CrossOrigin(origins = "*")
public class AttendanceController {
 private final AttendanceRepository repository;
 public AttendanceController(AttendanceRepository repository) { this.repository = repository; }
 @GetMapping public List<Attendance> listar() { return repository.findAll(); }
 @GetMapping("/{id}") public ResponseEntity<Attendance> obtener(@PathVariable Integer id) { return repository.findById(id).map(ResponseEntity::ok).orElseGet(() -> ResponseEntity.notFound().build()); }
 @PostMapping public Attendance crear(@RequestBody Attendance entidad) { entidad.setAttendanceId(null); return repository.save(entidad); }
 @PutMapping("/{id}") public ResponseEntity<Attendance> actualizar(@PathVariable Integer id, @RequestBody Attendance entidad) { if (!repository.existsById(id)) return ResponseEntity.notFound().build(); entidad.setAttendanceId(id); return ResponseEntity.ok(repository.save(entidad)); }
 @DeleteMapping("/{id}") public ResponseEntity<Void> eliminar(@PathVariable Integer id) { if (!repository.existsById(id)) return ResponseEntity.notFound().build(); repository.deleteById(id); return ResponseEntity.noContent().build(); }
}
