import 'package:octopoints/db/db.dart';
import 'package:octopoints/model/model.dart';
import 'package:octopoints/services/dto/EntityDto.dart';
import 'package:octopoints/services/interfaces/CRDService.dart';

class MatchService implements CRDService<MatchModel> {
  @override
  Future<MatchModel> create(MatchModel match) async {
    try {
      int id = await DbSingleton()
          .db
          .matchDao
          .create(EntityDto.toMatchEntity(match));
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
                entities.map((e) => EntityDto.toMatchModel(e)).toList(),
          );
    } on Exception catch (e) {
      throw e;
    }
  }
}
