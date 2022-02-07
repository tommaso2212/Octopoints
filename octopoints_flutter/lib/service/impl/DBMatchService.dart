import 'package:octopoints_flutter/db/DbSingleton.dart';
import 'package:octopoints_flutter/db/dao/MatchDao.dart';
import 'package:octopoints_flutter/db/entity/MatchEntity.dart';
import 'package:octopoints_flutter/service/DBService.dart';
import 'package:octopoints_flutter/service/model/Match.dart';
import 'package:octopoints_flutter/service/utils/GetListFilter.dart';

class DBMatchService extends DBService<Match, MatchEntity> {
  @override
  MatchDao get dao => DbSingleton().db.matchDao;

  @override
  MatchEntity entityMapper(Match model) {
    return MatchEntity(model.id == 0 ? null : model.id, model.description, model.gameMode.index, model.points, model.survivors, model.isActive);
  }

  @override
  Future<List<Match>> getList(GetListFilter filters) async {
    if(filters.isActive != null){
      List<MatchEntity> list = await (dao).getMatches(filters.isActive!);
      return list.map((e) => Match(e.description, GameMode.values[e.gameMode], e.points, e.survivors, isActive: e.isActive, id: e.id!)).toList();
    }
    return [];
  }

}