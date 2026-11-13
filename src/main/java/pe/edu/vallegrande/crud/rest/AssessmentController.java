package pe.edu.vallegrande.crud.rest;
import jakarta.validation.Valid; import org.springframework.http.HttpStatus; import org.springframework.web.bind.annotation.*; import pe.edu.vallegrande.crud.model.Assessment; import pe.edu.vallegrande.crud.repository.AssessmentRepository; import java.util.List;
@RestController @RequestMapping("/api/assessments") @CrossOrigin
public class AssessmentController { private final AssessmentRepository repository; public AssessmentController(AssessmentRepository repository){this.repository=repository;}
 @GetMapping public List<Assessment> list(){return repository.findAll();}
 @GetMapping("/{id}") public Assessment get(@PathVariable Integer id){return repository.findById(id).orElseThrow(()->new org.springframework.web.server.ResponseStatusException(HttpStatus.NOT_FOUND,"Registro no encontrado"));}
 @PostMapping @ResponseStatus(HttpStatus.CREATED) public Assessment create(@Valid @RequestBody Assessment value){return repository.save(value);}
 @PutMapping("/{id}") public Assessment update(@PathVariable Integer id,@Valid @RequestBody Assessment value){if(!repository.existsById(id))throw new org.springframework.web.server.ResponseStatusException(HttpStatus.NOT_FOUND,"Registro no encontrado");value.setId(id);return repository.save(value);}
 @DeleteMapping("/{id}") @ResponseStatus(HttpStatus.NO_CONTENT) public void delete(@PathVariable Integer id){if(!repository.existsById(id))throw new org.springframework.web.server.ResponseStatusException(HttpStatus.NOT_FOUND,"Registro no encontrado");repository.deleteById(id);}
}
