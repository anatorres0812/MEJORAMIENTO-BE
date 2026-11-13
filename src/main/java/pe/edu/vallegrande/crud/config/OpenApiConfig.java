
package pe.edu.vallegrande.crud.config;

import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Contact;
import io.swagger.v3.oas.models.info.Info;
import io.swagger.v3.oas.models.info.License;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class OpenApiConfig {

    @Bean
    public OpenAPI gestionAcademicaOpenAPI() {
        return new OpenAPI()
                .info(new Info()
                        .title("API - Gestión Académica TorresAna")
                        .description(
                                "API REST para la gestión académica: " +
                                "estudiantes, docentes, matrículas, " +
                                "asistencia, cursos, competencias y notas."
                        )
                        .version("1.0.0")
                        .contact(new Contact()
                                .name("TorresAna")
                                .email("soporte@torresana.com"))
                        .license(new License()
                                .name("Uso académico")));
    }
}
