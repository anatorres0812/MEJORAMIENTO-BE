package pe.edu.vallegrande.crud.auth;

import org.springframework.stereotype.Service;

@Service
public class AuthService {

    public String autenticar(LoginRequest request) {
        if (request == null
                || request.getUsername() == null
                || request.getPassword() == null
                || request.getUsername().isBlank()
                || request.getPassword().isBlank()) {
            throw new IllegalArgumentException(
                "Ingresa tu usuario y contraseña."
            );
        }

        /*
         * La autenticación real debe consultar usuarios registrados
         * y verificar contraseñas almacenadas de forma segura.
         * No se debe aceptar un usuario únicamente por su rol o DNI.
         */
        throw new UnsupportedOperationException(
            "La autenticación aún necesita conectarse con los usuarios registrados."
        );
    }
}