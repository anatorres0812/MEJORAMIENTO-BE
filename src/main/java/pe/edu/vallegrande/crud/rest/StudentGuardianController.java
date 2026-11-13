package pe.edu.vallegrande.crud.rest;
import jakarta.validation.Valid; import org.springframework.http.HttpStatus; import org.springframework.web.bind.annotation.*; import pe.edu.vallegrande.crud.model.StudentGuardian; import pe.edu.vallegrande.crud.model.StudentGuardianId; import pe.edu.vallegrande.crud.repository.StudentGuardianRepository; import java.util.List;
@RestController @RequestMapping("/api/student-guardians") @CrossOrigin
public class StudentGuardianController {
 private final StudentGuardianRepository repository; public StudentGuardianController(StudentGuardianRepository repository){this.repository=repository;}
 @GetMapping public List<StudentGuardian> list(){return repository.findAll();}
 @GetMapping("/{studentId}/{guardianId}") public StudentGuardian get(@PathVariable Integer studentId,@PathVariable Integer guardianId){return repository.findById(new StudentGuardianId(studentId,guardianId)).orElseThrow(()->new org.springframework.web.server.ResponseStatusException(HttpStatus.NOT_FOUND,"Relación no encontrada"));}
 @PostMapping @ResponseStatus(HttpStatus.CREATED) public StudentGuardian create(@Valid @RequestBody StudentGuardian value){return repository.save(value);}
 @DeleteMapping("/{studentId}/{guardianId}") @ResponseStatus(HttpStatus.NO_CONTENT) public void delete(@PathVariable Integer studentId,@PathVariable Integer guardianId){StudentGuardianId id=new StudentGuardianId(studentId,guardianId);if(!repository.existsById(id))throw new org.springframework.web.server.ResponseStatusException(HttpStatus.NOT_FOUND,"Relación no encontrada");repository.deleteById(id);}
}
