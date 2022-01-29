abstract class CRService<T> {
  Future<T> create(T item);
  Future<void> delete(T item);
}
