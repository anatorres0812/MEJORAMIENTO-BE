
package pe.edu.vallegrande.crud.dto;

import jakarta.validation.constraints.*;

public class CopyOfCompetencyDTO {
    private Integer competencyId;

    @NotBlank @Size(max = 20)
    private String code;

    @NotBlank @Size(max = 200)
    private String competencyName;

    @Size(max = 500)
    private String description;

    private Integer courseId;

    @NotBlank @Size(max = 15)
    private String educationLevel;

    @NotBlank
    @Pattern(regexp = "ACTIVE|INACTIVE")
    private String status = "ACTIVE";

    public CopyOfCompetencyDTO() {}

    public Integer getCompetencyId() { return competencyId; }
    public void setCompetencyId(Integer v) { competencyId = v; }
    public String getCode() { return code; }
    public void setCode(String v) { code = v; }
    public String getCompetencyName() { return competencyName; }
    public void setCompetencyName(String v) { competencyName = v; }
    public String getDescription() { return description; }
    public void setDescription(String v) { description = v; }
    public Integer getCourseId() { return courseId; }
    public void setCourseId(Integer v) { courseId = v; }
    public String getEducationLevel() { return educationLevel; }
    public void setEducationLevel(String v) { educationLevel = v; }
    public String getStatus() { return status; }
    public void setStatus(String v) { status = v; }
}
