
package pe.edu.vallegrande.crud.dto;

import java.time.LocalDateTime;
import java.util.Map;

public class ErrorResponseDTO {
    private LocalDateTime timestamp;
    private int status;
    private String error;
    private String message;
    private String path;
    private Map<String, String> validationErrors;

    public ErrorResponseDTO() {
        this.timestamp = LocalDateTime.now();
    }

    public ErrorResponseDTO(int status, String error, String message, String path) {
        this.timestamp = LocalDateTime.now();
        this.status = status;
        this.error = error;
        this.message = message;
        this.path = path;
    }

    public LocalDateTime getTimestamp() { return timestamp; }
    public void setTimestamp(LocalDateTime v) { timestamp = v; }
    public int getStatus() { return status; }
    public void setStatus(int v) { status = v; }
    public String getError() { return error; }
    public void setError(String v) { error = v; }
    public String getMessage() { return message; }
    public void setMessage(String v) { message = v; }
    public String getPath() { return path; }
    public void setPath(String v) { path = v; }
    public Map<String, String> getValidationErrors() { return validationErrors; }
    public void setValidationErrors(Map<String, String> v) { validationErrors = v; }
}
