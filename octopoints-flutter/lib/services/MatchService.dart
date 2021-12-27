import 'package:octopoints/db/DbSingleton.dart';
import 'package:octopoints/db/utils/EntityConverter.dart';
import 'package:octopoints/model/MatchModel.dart';
import 'package:octopoints/services/IService.dart';

class MatchService implements IService<MatchModel> {
  @override
  Future<MatchModel> create(MatchModel match) async {
    try {
      int id = await DbSingleton()
          .db
          .matchDao
          .create(EntityConverter.toMatchEntity(match));
      return match.setId(id);
    } on Exception catch (e) {
      throw e;
    }
  }

  @override
  Future<void> delete(MatchModel match) async {
    try {
      await DbSingleton().db.matchDao.delete(match.id!);
    } on Exception catch (e) {
      throw e;
    }
  }

  @override
  Future<List<MatchModel>> getAll({int? byId}) async {
    try {
      return await DbSingleton()
          .db
          .matchDao
          .getAllMatches()
          .then<List<MatchModel>>(
            (entities) =>
                entities.map((e) => EntityConverter.toMatchModel(e)).toList(),
          );
    } on Exception catch (e) {
      throw e;
    }
  }
}
