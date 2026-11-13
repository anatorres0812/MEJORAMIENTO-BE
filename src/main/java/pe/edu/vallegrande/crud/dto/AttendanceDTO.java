
package pe.edu.vallegrande.crud.dto;

import jakarta.validation.constraints.*;

public class AttendanceDTO {
    private Integer attendanceId;

    @NotNull @Positive
    private Integer enrollmentId;

    @NotNull @Positive
    private Integer courseId;

    @NotNull @Positive
    private Integer academicPeriodId;

    @NotNull @Positive
    private Integer teacherId;

    @NotBlank @Size(max = 10)
    private String attendanceDate;

    @NotBlank
    @Pattern(regexp = "PRESENT|ABSENT|LATE|JUSTIFIED")
    private String attendanceStatus;

    @Size(max = 500)
    private String observation;

    @NotBlank
    @Pattern(regexp = "ACTIVE|INACTIVE")
    private String status = "ACTIVE";

    public AttendanceDTO() {}

    public Integer getAttendanceId() { return attendanceId; }
    public void setAttendanceId(Integer v) { attendanceId = v; }
    public Integer getEnrollmentId() { return enrollmentId; }
    public void setEnrollmentId(Integer v) { enrollmentId = v; }
    public Integer getCourseId() { return courseId; }
    public void setCourseId(Integer v) { courseId = v; }
    public Integer getAcademicPeriodId() { return academicPeriodId; }
    public void setAcademicPeriodId(Integer v) { academicPeriodId = v; }
    public Integer getTeacherId() { return teacherId; }
    public void setTeacherId(Integer v) { teacherId = v; }
    public String getAttendanceDate() { return attendanceDate; }
    public void setAttendanceDate(String v) { attendanceDate = v; }
    public String getAttendanceStatus() { return attendanceStatus; }
    public void setAttendanceStatus(String v) { attendanceStatus = v; }
    public String getObservation() { return observation; }
    public void setObservation(String v) { observation = v; }
    public String getStatus() { return status; }
    public void setStatus(String v) { status = v; }
}
