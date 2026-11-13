
package pe.edu.vallegrande.crud.dto;

import jakarta.validation.constraints.*;

public class EnrollmentDTO {
    private Integer enrollmentId;

    @NotNull @Positive
    private Integer studentId;

    @NotBlank @Size(max = 15)
    private String educationLevel;

    @NotNull @Positive
    private Long gradeId;

    @NotNull @Positive
    private Long sectionId;

    @NotNull @Positive
    private Integer academicPeriodId;

    @NotNull @Min(2000) @Max(2100)
    private Integer academicYear;

    @NotBlank @Size(max = 10)
    private String enrollmentDate;

    @Size(max = 20)
    private String guardianDocumentNumber;

    @Size(max = 100)
    private String guardianFirstName;

    @Size(max = 100)
    private String guardianLastName;

    @Size(max = 50)
    private String guardianRelationship;

    @Size(max = 15)
    private String guardianPhone;

    @NotBlank
    @Pattern(regexp = "ACTIVE|INACTIVE|COMPLETED")
    private String status = "ACTIVE";

    public EnrollmentDTO() {}

    public Integer getEnrollmentId() { return enrollmentId; }
    public void setEnrollmentId(Integer v) { enrollmentId = v; }
    public Integer getStudentId() { return studentId; }
    public void setStudentId(Integer v) { studentId = v; }
    public String getEducationLevel() { return educationLevel; }
    public void setEducationLevel(String v) { educationLevel = v; }
    public Long getGradeId() { return gradeId; }
    public void setGradeId(Long v) { gradeId = v; }
    public Long getSectionId() { return sectionId; }
    public void setSectionId(Long v) { sectionId = v; }
    public Integer getAcademicPeriodId() { return academicPeriodId; }
    public void setAcademicPeriodId(Integer v) { academicPeriodId = v; }
    public Integer getAcademicYear() { return academicYear; }
    public void setAcademicYear(Integer v) { academicYear = v; }
    public String getEnrollmentDate() { return enrollmentDate; }
    public void setEnrollmentDate(String v) { enrollmentDate = v; }
    public String getGuardianDocumentNumber() { return guardianDocumentNumber; }
    public void setGuardianDocumentNumber(String v) { guardianDocumentNumber = v; }
    public String getGuardianFirstName() { return guardianFirstName; }
    public void setGuardianFirstName(String v) { guardianFirstName = v; }
    public String getGuardianLastName() { return guardianLastName; }
    public void setGuardianLastName(String v) { guardianLastName = v; }
    public String getGuardianRelationship() { return guardianRelationship; }
    public void setGuardianRelationship(String v) { guardianRelationship = v; }
    public String getGuardianPhone() { return guardianPhone; }
    public void setGuardianPhone(String v) { guardianPhone = v; }
    public String getStatus() { return status; }
    public void setStatus(String v) { status = v; }
}
