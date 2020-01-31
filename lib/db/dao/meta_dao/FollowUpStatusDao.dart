
import 'package:ehr_mobile/db/tables/meta_tables/FollowUpStatusTable.dart';
import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';

import 'MetaDao.dart';

class FollowUpStatusDao extends MetaDao{
  FollowUpStatusDao(SqfliteAdapter adapter) : super(adapter);

  SqfliteAdapter _adapter;

  @override
  String get tableName => 'FollowUpStatus';

  /// Finds all
  @override
  Future<List<FollowUpStatusTable>> findAll() async {
    Find finder = new Find(tableName);

    List<Map> maps = (await _adapter.find(finder)).toList();

    var sts = new List<FollowUpStatusTable>();

    for (Map map in maps) {
      var status = FollowUpStatusTable().fromJson(map);
      sts.add(status);
    }
    return sts;
  }

}