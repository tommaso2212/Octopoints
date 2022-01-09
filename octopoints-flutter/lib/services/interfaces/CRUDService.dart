import 'CRDService.dart';

abstract class CRUDService<T> extends CRDService<T> {
  Future<void> update(List<T> items);
}
