
package pe.edu.vallegrande.crud.dto;

import jakarta.validation.constraints.*;

public class CopyOfCourseGradeDTO {
    private Integer curseId;

    @NotNull @Positive
    private Long gradeId;

    @NotNull @Positive
    private Integer courseId;

    public CopyOfCourseGradeDTO() {}

    public Integer getCurseId() { return curseId; }
    public void setCurseId(Integer v) { curseId = v; }
    public Long getGradeId() { return gradeId; }
    public void setGradeId(Long v) { gradeId = v; }
    public Integer getCourseId() { return courseId; }
    public void setCourseId(Integer v) { courseId = v; }
}
