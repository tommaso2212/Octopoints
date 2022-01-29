import 'CRService.dart';

abstract class CRDService<T> extends CRService<T> {
  Future<List<T>> getAll({int? byId});
}
