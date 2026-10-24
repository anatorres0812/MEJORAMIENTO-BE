
package pe.edu.vallegrande.crud.dto;

import jakarta.validation.constraints.*;

public class TeacherDTO {
    private Integer teacherId;

    @NotBlank @Size(max = 10)
    private String documentType;

    @NotBlank @Size(max = 120)
    private String documentNumber;

    @NotBlank @Size(max = 100)
    private String firstName;

    @NotBlank @Size(max = 100)
    private String lastName;

    @Size(max = 150)
    private String specialty;

    @Size(max = 15)
    private String educationLevel;

    @Size(max = 15)
    private String phone;

    @Email @Size(max = 150)
    private String email;

    @Size(max = 10)
    private String hireDate;

    @NotBlank
    @Pattern(regexp = "ACTIVE|INACTIVE")
    private String status = "ACTIVE";

    public TeacherDTO() {}

    public Integer getTeacherId() { return teacherId; }
    public void setTeacherId(Integer v) { teacherId = v; }
    public String getDocumentType() { return documentType; }
    public void setDocumentType(String v) { documentType = v; }
    public String getDocumentNumber() { return documentNumber; }
    public void setDocumentNumber(String v) { documentNumber = v; }
    public String getFirstName() { return firstName; }
    public void setFirstName(String v) { firstName = v; }
    public String getLastName() { return lastName; }
    public void setLastName(String v) { lastName = v; }
    public String getSpecialty() { return specialty; }
    public void setSpecialty(String v) { specialty = v; }
    public String getEducationLevel() { return educationLevel; }
    public void setEducationLevel(String v) { educationLevel = v; }
    public String getPhone() { return phone; }
    public void setPhone(String v) { phone = v; }
    public String getEmail() { return email; }
    public void setEmail(String v) { email = v; }
    public String getHireDate() { return hireDate; }
    public void setHireDate(String v) { hireDate = v; }
    public String getStatus() { return status; }
    public void setStatus(String v) { status = v; }
}
