
package pe.edu.vallegrande.crud.dto;

import jakarta.validation.constraints.*;

public class AcademicPeriodDTO {
    private Integer academicPeriodId;

    @NotBlank
    @Size(max = 100)
    private String periodName;

    @NotNull
    @Min(2000)
    @Max(2100)
    private Integer academicYear;

    @NotBlank
    @Size(max = 10)
    private String startDate;

    @NotBlank
    @Size(max = 10)
    private String endDate;

    private Boolean isActive = true;

    @NotBlank
    @Pattern(regexp = "ACTIVE|INACTIVE")
    private String status = "ACTIVE";

    public AcademicPeriodDTO() {}

    public Integer getAcademicPeriodId() { return academicPeriodId; }
    public void setAcademicPeriodId(Integer id) { this.academicPeriodId = id; }
    public String getPeriodName() { return periodName; }
    public void setPeriodName(String value) { this.periodName = value; }
    public Integer getAcademicYear() { return academicYear; }
    public void setAcademicYear(Integer value) { this.academicYear = value; }
    public String getStartDate() { return startDate; }
    public void setStartDate(String value) { this.startDate = value; }
    public String getEndDate() { return endDate; }
    public void setEndDate(String value) { this.endDate = value; }
    public Boolean getIsActive() { return isActive; }
    public void setIsActive(Boolean value) { this.isActive = value; }
    public String getStatus() { return status; }
    public void setStatus(String value) { this.status = value; }
}
