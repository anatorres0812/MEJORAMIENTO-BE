
package pe.edu.vallegrande.crud.dto;

public class ApiResponseDTO<T> {
    private boolean success;
    private String message;
    private T data;

    public ApiResponseDTO() {}

    public ApiResponseDTO(boolean success, String message, T data) {
        this.success = success;
        this.message = message;
        this.data = data;
    }

    public static <T> ApiResponseDTO<T> success(String message, T data) {
        return new ApiResponseDTO<>(true, message, data);
    }

    public static <T> ApiResponseDTO<T> error(String message) {
        return new ApiResponseDTO<>(false, message, null);
    }

    public boolean isSuccess() { return success; }
    public void setSuccess(boolean v) { success = v; }
    public String getMessage() { return message; }
    public void setMessage(String v) { message = v; }
    public T getData() { return data; }
    public void setData(T v) { data = v; }
}
