import 'package:flutter/cupertino.dart';

abstract class OctopointsProvider<T> extends ChangeNotifier {
  List<T>? _data;

  Future<List<T>> getData() => Future.value([]);

  Future<List<T>> get data => _data != null ? Future.value(_data) : getData().then((value) => _data=value);

  void create(T item) async {
    (await data).add(item);
    notifyListeners();
  }

  void delete(T item) async {
    (await data).remove(item);
    notifyListeners();
  }
}
