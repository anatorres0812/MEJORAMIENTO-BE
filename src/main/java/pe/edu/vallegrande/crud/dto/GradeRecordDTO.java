
package pe.edu.vallegrande.crud.dto;

import jakarta.validation.constraints.*;

public class GradeRecordDTO {
    private Integer gradeRecordId;

    @NotNull @Positive
    private Integer enrollmentId;

    @NotNull @Positive
    private Integer competencyId;

    @NotNull @Positive
    private Integer courseId;

    @NotNull @Positive
    private Integer academicPeriodId;

    @NotNull @Positive
    private Integer teacherId;

    @NotBlank @Size(max = 5)
    private String gradeValues;

    @Size(max = 500)
    private String observation;

    @NotBlank @Size(max = 10)
    private String recordedDate;

    @NotBlank
    @Pattern(regexp = "ACTIVE|INACTIVE")
    private String status = "ACTIVE";

    public GradeRecordDTO() {}

    public Integer getGradeRecordId() { return gradeRecordId; }
    public void setGradeRecordId(Integer v) { gradeRecordId = v; }
    public Integer getEnrollmentId() { return enrollmentId; }
    public void setEnrollmentId(Integer v) { enrollmentId = v; }
    public Integer getCompetencyId() { return competencyId; }
    public void setCompetencyId(Integer v) { competencyId = v; }
    public Integer getCourseId() { return courseId; }
    public void setCourseId(Integer v) { courseId = v; }
    public Integer getAcademicPeriodId() { return academicPeriodId; }
    public void setAcademicPeriodId(Integer v) { academicPeriodId = v; }
    public Integer getTeacherId() { return teacherId; }
    public void setTeacherId(Integer v) { teacherId = v; }
    public String getGradeValues() { return gradeValues; }
    public void setGradeValues(String v) { gradeValues = v; }
    public String getObservation() { return observation; }
    public void setObservation(String v) { observation = v; }
    public String getRecordedDate() { return recordedDate; }
    public void setRecordedDate(String v) { recordedDate = v; }
    public String getStatus() { return status; }
    public void setStatus(String v) { status = v; }
}
