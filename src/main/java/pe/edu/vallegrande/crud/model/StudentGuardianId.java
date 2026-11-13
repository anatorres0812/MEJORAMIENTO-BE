package pe.edu.vallegrande.crud.model;
import java.io.Serializable; import java.util.Objects;
public class StudentGuardianId implements Serializable { private Integer studentId; private Integer guardianId; public StudentGuardianId(){} public StudentGuardianId(Integer s,Integer g){studentId=s;guardianId=g;} public boolean equals(Object o){if(this==o)return true;if(!(o instanceof StudentGuardianId x))return false;return Objects.equals(studentId,x.studentId)&&Objects.equals(guardianId,x.guardianId);} public int hashCode(){return Objects.hash(studentId,guardianId);} }
