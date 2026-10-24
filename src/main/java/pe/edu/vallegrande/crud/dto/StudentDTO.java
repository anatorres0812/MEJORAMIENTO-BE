
package pe.edu.vallegrande.crud.dto;

import jakarta.validation.constraints.*;

public class StudentDTO {
    private Integer studentId;

    @NotBlank @Size(max = 20)
    private String code;

    @NotBlank @Size(max = 3)
    private String documentType;

    @NotBlank @Size(max = 20)
    private String documentNumber;

    @NotBlank @Size(max = 100)
    private String firstName;

    @NotBlank @Size(max = 100)
    private String lastName;

    @Size(max = 10)
    private String birthDate;

    @Size(max = 1)
    private String gender;

    @Size(max = 100)
    private String guardianName;

    @Size(max = 15)
    private String guardianPhone;

    @Size(max = 100)
    private String guardianLastName;

    @Size(max = 50)
    private String guardianRelationship;

    @NotBlank @Size(max = 15)
    private String educationLevel;

    @NotNull @Positive
    private Long gradeId;

    @NotNull @Positive
    private Long sectionId;

    @NotBlank
    @Pattern(regexp = "ACTIVE|INACTIVE")
    private String status = "ACTIVE";

    public StudentDTO() {}

    public Integer getStudentId() { return studentId; }
    public void setStudentId(Integer v) { studentId = v; }
    public String getCode() { return code; }
    public void setCode(String v) { code = v; }
    public String getDocumentType() { return documentType; }
    public void setDocumentType(String v) { documentType = v; }
    public String getDocumentNumber() { return documentNumber; }
    public void setDocumentNumber(String v) { documentNumber = v; }
    public String getFirstName() { return firstName; }
    public void setFirstName(String v) { firstName = v; }
    public String getLastName() { return lastName; }
    public void setLastName(String v) { lastName = v; }
    public String getBirthDate() { return birthDate; }
    public void setBirthDate(String v) { birthDate = v; }
    public String getGender() { return gender; }
    public void setGender(String v) { gender = v; }
    public String getGuardianName() { return guardianName; }
    public void setGuardianName(String v) { guardianName = v; }
    public String getGuardianPhone() { return guardianPhone; }
    public void setGuardianPhone(String v) { guardianPhone = v; }
    public String getGuardianLastName() { return guardianLastName; }
    public void setGuardianLastName(String v) { guardianLastName = v; }
    public String getGuardianRelationship() { return guardianRelationship; }
    public void setGuardianRelationship(String v) { guardianRelationship = v; }
    public String getEducationLevel() { return educationLevel; }
    public void setEducationLevel(String v) { educationLevel = v; }
    public Long getGradeId() { return gradeId; }
    public void setGradeId(Long v) { gradeId = v; }
    public Long getSectionId() { return sectionId; }
    public void setSectionId(Long v) { sectionId = v; }
    public String getStatus() { return status; }
    public void setStatus(String v) { status = v; }
}
