import 'package:flutter/cupertino.dart';

abstract class OctopointsProvider<T> extends ChangeNotifier {
  List<T>? _data;

  Future<List<T>> getData();

  Future<List<T>> get data => _data != null ? Future.value(_data) : getData();
}
