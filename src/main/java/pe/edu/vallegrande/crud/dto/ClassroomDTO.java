
package pe.edu.vallegrande.crud.dto;

import jakarta.validation.constraints.*;

public class ClassroomDTO {

    private Integer classroomId;

    @NotBlank(message = "El código es obligatorio")
    @Size(max = 30)
    private String code;

    @NotBlank(message = "El nombre del aula es obligatorio")
    @Size(max = 100)
    private String classroomName;

    @NotBlank(message = "El nivel educativo es obligatorio")
    @Size(max = 15)
    private String educationLevel;

    @NotNull
    @Min(2000)
    @Max(2100)
    private Integer academicYear;

    @NotNull
    @Positive
    private Long gradeId;

    @NotNull
    @Positive
    private Long sectionId;

    @NotNull
    @Min(1)
    private Integer capacity;

    private Integer teacherId;

    @NotBlank
    @Pattern(regexp = "ACTIVE|INACTIVE")
    private String status = "ACTIVE";

    public ClassroomDTO() {}

    public Integer getClassroomId() { return classroomId; }
    public void setClassroomId(Integer classroomId) { this.classroomId = classroomId; }

    public String getCode() { return code; }
    public void setCode(String code) { this.code = code; }

    public String getClassroomName() { return classroomName; }
    public void setClassroomName(String classroomName) { this.classroomName = classroomName; }

    public String getEducationLevel() { return educationLevel; }
    public void setEducationLevel(String educationLevel) { this.educationLevel = educationLevel; }

    public Integer getAcademicYear() { return academicYear; }
    public void setAcademicYear(Integer academicYear) { this.academicYear = academicYear; }

    public Long getGradeId() { return gradeId; }
    public void setGradeId(Long gradeId) { this.gradeId = gradeId; }

    public Long getSectionId() { return sectionId; }
    public void setSectionId(Long sectionId) { this.sectionId = sectionId; }

    public Integer getCapacity() { return capacity; }
    public void setCapacity(Integer capacity) { this.capacity = capacity; }

    public Integer getTeacherId() { return teacherId; }
    public void setTeacherId(Integer teacherId) { this.teacherId = teacherId; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}
