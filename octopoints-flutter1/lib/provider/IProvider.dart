import 'package:flutter/material.dart';
import 'package:octopoints/services/ServiceFactory.dart';

class IProvider<T> extends ChangeNotifier {
  List<T> _list = [];
  bool _isAlreadyInit = false;

  Future<List<T>> getAll({int? byId}) async {
    if (!_isAlreadyInit) {
      _isAlreadyInit = true;
      this._list =
          (await ServiceFactory.getService<T>().getAll(byId: byId) as List<T>);
    }
    return this._list;
  }

  Future<void> add(T item) =>
      ServiceFactory.getService<T>().create(item).then((value) {
        this._list.add(value);
        notifyListeners();
      });

  Future<void> remove(T item) =>
      ServiceFactory.getService<T>().delete(item).then((_) {
        this._list.remove(item);
        notifyListeners();
      });
}
