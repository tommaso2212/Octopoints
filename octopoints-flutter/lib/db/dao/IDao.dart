import 'package:floor/floor.dart';

abstract class IDao<T> {
  @insert
  Future<int> create(T t);
  @update
  Future<void> modify(List<T> t);
}
