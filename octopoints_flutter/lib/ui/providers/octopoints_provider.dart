import 'package:flutter/material.dart';

abstract class OctopointsProvider<T> extends ChangeNotifier {
  final List<T> _listData = [];
  final GlobalKey<AnimatedListState> listKey = GlobalKey();
  bool _alreadyInit = false;

  Future<List<T>> getData();

  List<T> get data {
    if (!_alreadyInit) {
      _setData();
    }
    return _listData;
  }

  void _setData() async {
    _alreadyInit = true;
    for (T item in await getData()) {
      addItem(item);
    }
  }

  void addItem(T item) {
    _listData.add(item);
    listKey.currentState!.insertItem(_listData.length - 1);
  }

  void updateItem(T item){
    _listData[_listData.indexOf(item)] = item;
    notifyListeners();
  }

  void removeItem(T item) {
    listKey.currentState!.removeItem(_listData.indexOf(item),
        (context, animation) => SizeTransition(sizeFactor: animation));
    _listData.remove(item);
  }
}
