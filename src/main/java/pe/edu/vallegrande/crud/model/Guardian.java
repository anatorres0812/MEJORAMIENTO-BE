package pe.edu.vallegrande.crud.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import java.time.LocalDateTime;

@Entity @Table(name="guardian", uniqueConstraints=@UniqueConstraint(name="UQ_guardian_document", columnNames={"document_type","document_number"}))
public class Guardian {
 @Id @GeneratedValue(strategy=GenerationType.IDENTITY) @Column(name="guardian_id") private Integer id;
 @NotBlank @Size(max=10) @Column(name="document_type", nullable=false, length=10) private String documentType;
 @NotBlank @Size(max=20) @Column(name="document_number", nullable=false, length=20) private String documentNumber;
 @NotBlank @Size(max=100) @Column(name="first_name", nullable=false) private String firstName;
 @NotBlank @Size(max=100) @Column(name="last_name", nullable=false) private String lastName;
 @NotBlank @Pattern(regexp="9[0-9]{8}") @Column(nullable=false,length=20) private String phone;
 @Email @Size(max=150) private String email;
 @Column(name="created_at", insertable=false, updatable=false) private LocalDateTime createdAt;
 @Column(name="updated_at", insertable=false, updatable=false) private LocalDateTime updatedAt;
 public Integer getId(){return id;} public void setId(Integer v){id=v;}
 public String getDocumentType(){return documentType;} public void setDocumentType(String v){documentType=v;}
 public String getDocumentNumber(){return documentNumber;} public void setDocumentNumber(String v){documentNumber=v;}
 public String getFirstName(){return firstName;} public void setFirstName(String v){firstName=v;}
 public String getLastName(){return lastName;} public void setLastName(String v){lastName=v;}
 public String getPhone(){return phone;} public void setPhone(String v){phone=v;}
 public String getEmail(){return email;} public void setEmail(String v){email=v;}
 public LocalDateTime getCreatedAt(){return createdAt;} public LocalDateTime getUpdatedAt(){return updatedAt;}
}
