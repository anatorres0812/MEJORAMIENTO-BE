package pe.edu.vallegrande.crud.rest;
import jakarta.validation.Valid; import org.springframework.http.HttpStatus; import org.springframework.web.bind.annotation.*; import pe.edu.vallegrande.crud.model.SectionCourse; import pe.edu.vallegrande.crud.repository.SectionCourseRepository; import java.util.List;
@RestController @RequestMapping("/api/section-courses") @CrossOrigin
public class SectionCourseController { private final SectionCourseRepository repository; public SectionCourseController(SectionCourseRepository repository){this.repository=repository;}
 @GetMapping public List<SectionCourse> list(){return repository.findAll();}
 @GetMapping("/{id}") public SectionCourse get(@PathVariable Integer id){return repository.findById(id).orElseThrow(()->new org.springframework.web.server.ResponseStatusException(HttpStatus.NOT_FOUND,"Registro no encontrado"));}
 @PostMapping @ResponseStatus(HttpStatus.CREATED) public SectionCourse create(@Valid @RequestBody SectionCourse value){return repository.save(value);}
 @PutMapping("/{id}") public SectionCourse update(@PathVariable Integer id,@Valid @RequestBody SectionCourse value){if(!repository.existsById(id))throw new org.springframework.web.server.ResponseStatusException(HttpStatus.NOT_FOUND,"Registro no encontrado");value.setId(id);return repository.save(value);}
 @DeleteMapping("/{id}") @ResponseStatus(HttpStatus.NO_CONTENT) public void delete(@PathVariable Integer id){if(!repository.existsById(id))throw new org.springframework.web.server.ResponseStatusException(HttpStatus.NOT_FOUND,"Registro no encontrado");repository.deleteById(id);}
}
