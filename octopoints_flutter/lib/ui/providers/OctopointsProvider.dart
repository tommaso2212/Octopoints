import 'package:flutter/material.dart';
import 'package:octopoints_flutter/service/model/OctopointsModel.dart';
import 'package:octopoints_flutter/service/service.dart';

abstract class OctopointsProvider<T extends OctopointsModel> extends ChangeNotifier {
  List<T>? _list;
  DBService get service;

  Future<List<T>> getList({int? byId, bool active = true}) async {
    _list ??= (await service.getList(GetListFilter().setId(byId).setIsActive(active))).cast<T>();
    return _list!;
  }

  Future<void> add(T model) => service.create(model).then((_) {
        _list!.add(model);
      });

  Future<void> remove(T model) => service.delete(model).then(
        (isError) => isError ? throw Exception() : _list!.remove(model),
      );

  Future<void> update(List<T> models) =>
      service.update(models).then(
            (isError) => isError ? throw Exception() : null,
          );
}
