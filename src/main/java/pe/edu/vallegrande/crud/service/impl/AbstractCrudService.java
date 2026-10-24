package pe.edu.vallegrande.crud.service.impl;

import org.springframework.data.jpa.repository.JpaRepository;
import pe.edu.vallegrande.crud.service.CrudService;
import java.util.List;
import java.util.Optional;

public abstract class AbstractCrudService<T, ID> implements CrudService<T, ID> {
    protected final JpaRepository<T, ID> repository;
    protected AbstractCrudService(JpaRepository<T, ID> repository) { this.repository = repository; }
    @Override public List<T> listar() { return repository.findAll(); }
    @Override public Optional<T> obtener(ID id) { return repository.findById(id); }
    @Override public T crear(T entidad) { return repository.save(entidad); }
    @Override public Optional<T> actualizar(ID id, T entidad) {
        if (!repository.existsById(id)) return Optional.empty();
        return Optional.of(repository.save(entidad));
    }
    @Override public boolean eliminar(ID id) {
        if (!repository.existsById(id)) return false;
        repository.deleteById(id); return true;
    }
}
