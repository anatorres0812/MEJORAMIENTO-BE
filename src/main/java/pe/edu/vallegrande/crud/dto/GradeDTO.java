
package pe.edu.vallegrande.crud.dto;

import jakarta.validation.constraints.*;

public class GradeDTO {

    private Long gradeId;

    @NotBlank(message = "El nombre del grado es obligatorio")
    @Size(max = 100)
    private String gradeName;

    @NotBlank(message = "El nivel educativo es obligatorio")
    @Size(max = 15)
    private String educationLevel;

    @NotNull(message = "El orden del grado es obligatorio")
    @Positive(message = "El orden debe ser positivo")
    private Integer gradeOrder;

    @Size(max = 255)
    private String description;

    @NotBlank(message = "El estado es obligatorio")
    @Pattern(regexp = "ACTIVE|INACTIVE", message = "Estado inválido")
    private String status = "ACTIVE";

    public GradeDTO() {}

    public Long getGradeId() { return gradeId; }
    public void setGradeId(Long gradeId) { this.gradeId = gradeId; }

    public String getGradeName() { return gradeName; }
    public void setGradeName(String gradeName) { this.gradeName = gradeName; }

    public String getEducationLevel() { return educationLevel; }
    public void setEducationLevel(String educationLevel) { this.educationLevel = educationLevel; }

    public Integer getGradeOrder() { return gradeOrder; }
    public void setGradeOrder(Integer gradeOrder) { this.gradeOrder = gradeOrder; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}
