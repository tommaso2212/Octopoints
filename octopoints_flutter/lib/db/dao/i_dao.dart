import 'package:floor_annotation/floor_annotation.dart';

abstract class IDao<T> {
  @insert
  Future<int> create(T t);
  @update
  Future<int> modify(List<T> t);
  @delete
  Future<int> remove(T t);
}
