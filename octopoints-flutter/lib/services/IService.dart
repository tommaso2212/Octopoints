abstract class IService<T> {
  Future<List<T>> getAll({int byId});
  Future<T> create(T t);
  Future<void> delete(T t);
}
