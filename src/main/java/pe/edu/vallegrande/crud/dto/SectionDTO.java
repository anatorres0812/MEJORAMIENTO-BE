
package pe.edu.vallegrande.crud.dto;

import jakarta.validation.constraints.*;

public class SectionDTO {

    private Long sectionId;

    @NotBlank(message = "El nombre de la sección es obligatorio")
    @Size(max = 50)
    private String sectionName;

    @NotNull(message = "La capacidad es obligatoria")
    @Min(value = 1, message = "La capacidad mínima es 1")
    private Integer capacity;

    @NotBlank(message = "El turno es obligatorio")
    @Size(max = 10)
    private String shift;

    @NotBlank(message = "El estado es obligatorio")
    @Pattern(regexp = "ACTIVE|INACTIVE", message = "Estado inválido")
    private String status = "ACTIVE";

    public SectionDTO() {}

    public Long getSectionId() { return sectionId; }
    public void setSectionId(Long sectionId) { this.sectionId = sectionId; }

    public String getSectionName() { return sectionName; }
    public void setSectionName(String sectionName) { this.sectionName = sectionName; }

    public Integer getCapacity() { return capacity; }
    public void setCapacity(Integer capacity) { this.capacity = capacity; }

    public String getShift() { return shift; }
    public void setShift(String shift) { this.shift = shift; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}
