import 'package:octopoints_flutter/db/dao/IDao.dart';
import 'package:octopoints_flutter/service/impl/DBMatchService.dart';
import 'package:octopoints_flutter/service/impl/DBTeamService.dart';
import 'package:octopoints_flutter/service/impl/DBUserService.dart';
import 'package:octopoints_flutter/service/model/OctopointsModel.dart';
import 'package:octopoints_flutter/service/utils/GetListFilter.dart';

abstract class DBService<T extends OctopointsModel, E> {
  IDao<E> get dao;
  E entityMapper(T model);

  Future<void> create(T model) async {
    int id = await dao.create(entityMapper(model));
    model.id = id;
  }

  Future<List<T>> getList(GetListFilter filters);

  Future<bool> update(List<T> list) async {
    return (await dao.modify(list.map((e) => entityMapper(e)).toList())) == list.length;
  }

  Future<bool> delete(T model) async {
    return (await dao.remove(entityMapper(model))) == 1;
  }

  static DBMatchService get matchService => DBMatchService();
  static DBUserService get userService => DBUserService();
  static DBTeamService get teamService => DBTeamService();
}