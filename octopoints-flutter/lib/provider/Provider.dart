import 'package:flutter/cupertino.dart';
import 'package:octopoints/services/IService.dart';

class Provider<T> extends ChangeNotifier {
  @protected
  IService<T> _service;
  @protected
  List<T> list = [];
  @protected
  bool isAlreadyInit = false;

  Provider(this._service);

  Future<List<T>> getAll() => !isAlreadyInit
      ? _service.getAll().then<List<T>>((list) {
          this.isAlreadyInit = true;
          this.list = list;
          return this.list;
        })
      : Future.value(this.list);

  Future<void> add(T item) => _service.create(item).then((value) {
        this.list.add(value);
        notifyListeners();
      });

  Future<void> remove(T item) => _service.delete(item).then((_) {
        this.list.remove(item);
        notifyListeners();
      });
}
