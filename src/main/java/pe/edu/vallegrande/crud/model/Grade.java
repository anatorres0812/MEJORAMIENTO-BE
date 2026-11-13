package pe.edu.vallegrande.crud.model;

import jakarta.persistence.*;

@Entity
@Table(name = "grade_level", schema = "dbo")
public class Grade {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "grade_id")
    private Integer gradeId;

    @Column(name = "grade_name", nullable = false, length = 100)
    private String gradeName;

    @Column(name = "education_level", nullable = false, length = 50)
    private String educationLevel;

    @Column(name = "grade_order", nullable = false)
    private Short gradeOrder;

    @Column(name = "status", nullable = false, length = 15)
    private String status;

    public Grade() {}
    public Integer getGradeId() { return gradeId; }
    public void setGradeId(Integer gradeId) { this.gradeId = gradeId; }
    public String getGradeName() { return gradeName; }
    public void setGradeName(String gradeName) { this.gradeName = gradeName; }
    public String getEducationLevel() { return educationLevel; }
    public void setEducationLevel(String educationLevel) { this.educationLevel = educationLevel; }
    public Short getGradeOrder() { return gradeOrder; }
    public void setGradeOrder(Short gradeOrder) { this.gradeOrder = gradeOrder; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}
