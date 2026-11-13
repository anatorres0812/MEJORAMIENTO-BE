package pe.edu.vallegrande.crud.model;
import jakarta.persistence.*;
@Entity @Table(name="student_guardian")
@IdClass(StudentGuardianId.class)
public class StudentGuardian {
 @Id @Column(name="student_id") private Integer studentId;
 @Id @Column(name="guardian_id") private Integer guardianId;
 @Column(nullable=false,length=50) private String relationship;
 @Column(name="is_primary",nullable=false) private Boolean primary=false;
 public Integer getStudentId(){return studentId;} public void setStudentId(Integer v){studentId=v;}
 public Integer getGuardianId(){return guardianId;} public void setGuardianId(Integer v){guardianId=v;}
 public String getRelationship(){return relationship;} public void setRelationship(String v){relationship=v;}
 public Boolean getPrimary(){return primary;} public void setPrimary(Boolean v){primary=v;}
}
