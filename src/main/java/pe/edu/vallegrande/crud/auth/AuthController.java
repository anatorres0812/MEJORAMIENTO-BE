package pe.edu.vallegrande.crud.auth;

import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/auth")
@CrossOrigin(origins = "http://localhost:4200")
public class AuthController {

    private final AuthService authService;

    public AuthController(AuthService authService) {
        this.authService = authService;
    }

    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody LoginRequest request) {
        try {
            String resultado = authService.autenticar(request);
            return ResponseEntity.ok(Map.of("mensaje", resultado));
        } catch (IllegalArgumentException e) {
            return ResponseEntity.badRequest()
                .body(Map.of("error", e.getMessage()));
        } catch (UnsupportedOperationException e) {
            return ResponseEntity.status(501)
                .body(Map.of("error", e.getMessage()));
        }
    }
}