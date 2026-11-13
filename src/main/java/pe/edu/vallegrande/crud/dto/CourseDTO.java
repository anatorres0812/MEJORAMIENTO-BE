
package pe.edu.vallegrande.crud.dto;

import jakarta.validation.constraints.*;

public class CourseDTO {
    private Integer courseId;

    @NotBlank @Size(max = 20)
    private String code;

    @NotBlank @Size(max = 150)
    private String courseName;

    @Size(max = 255)
    private String description;

    @NotBlank @Size(max = 15)
    private String educationLevel;

    @NotBlank
    @Pattern(regexp = "ACTIVE|INACTIVE")
    private String status = "ACTIVE";

    public CourseDTO() {}

    public Integer getCourseId() { return courseId; }
    public void setCourseId(Integer v) { courseId = v; }
    public String getCode() { return code; }
    public void setCode(String v) { code = v; }
    public String getCourseName() { return courseName; }
    public void setCourseName(String v) { courseName = v; }
    public String getDescription() { return description; }
    public void setDescription(String v) { description = v; }
    public String getEducationLevel() { return educationLevel; }
    public void setEducationLevel(String v) { educationLevel = v; }
    public String getStatus() { return status; }
    public void setStatus(String v) { status = v; }
}
