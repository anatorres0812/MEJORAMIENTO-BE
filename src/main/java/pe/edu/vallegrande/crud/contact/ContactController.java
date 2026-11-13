package pe.edu.vallegrande.crud.contact;

import java.util.Map;
import org.springframework.http.HttpStatus;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.server.ResponseStatusException;
import jakarta.validation.Valid;

@RestController
@RequestMapping("/api/contacto")
public class ContactController {
    private final JdbcTemplate jdbc;
    public ContactController(JdbcTemplate jdbc) { this.jdbc = jdbc; }

    @PostMapping
    public ResponseEntity<Map<String, Object>> create(@Valid @RequestBody ContactRequest request) {
        String sql = "INSERT INTO dbo.contact_message (full_name,email,subject,message) VALUES (?,?,?,?)";
        try {
            int rows = jdbc.update(sql, request.nombre().trim(), request.correo().trim(),
                request.asunto() == null || request.asunto().isBlank() ? null : request.asunto().trim(),
                request.mensaje().trim());
            if (rows != 1) throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, "No se pudo registrar el mensaje");
            return ResponseEntity.status(HttpStatus.CREATED).body(Map.of("message", "Mensaje recibido correctamente"));
        } catch (org.springframework.dao.DataAccessException ex) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "No se pudo registrar el mensaje. Verifica los datos y la conexión con la base de datos.", ex);
        }
    }
}
