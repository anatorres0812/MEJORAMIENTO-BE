package pe.edu.vallegrande.crud.service;

import java.util.List;
import java.util.Optional;

public interface CrudService<T, ID> {
    List<T> listar();
    Optional<T> obtener(ID id);
    T crear(T entidad);
    Optional<T> actualizar(ID id, T entidad);
    boolean eliminar(ID id);
}
