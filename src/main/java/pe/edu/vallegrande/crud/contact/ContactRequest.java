package pe.edu.vallegrande.crud.contact;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;

public record ContactRequest(
    @NotBlank(message = "El nombre es obligatorio")
    @Size(max = 150, message = "El nombre no puede superar 150 caracteres")
    String nombre,

    @NotBlank(message = "El correo es obligatorio")
    @Email(message = "El correo no tiene un formato válido")
    @Size(max = 254, message = "El correo no puede superar 254 caracteres")
    @Pattern(regexp = "(?i)^.+\\.(com|edu\\.pe)$", message = "El correo debe terminar en .com o .edu.pe")
    String correo,

    @Size(max = 500, message = "El asunto no puede superar 500 caracteres")
    String asunto,

    @NotBlank(message = "El mensaje es obligatorio")
    @Size(max = 2000, message = "El mensaje no puede superar 2000 caracteres")
    String mensaje
) {}
