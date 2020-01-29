

import 'package:ehr_mobile/db/dao/meta_dao/MetaDao.dart';
import 'package:jaguar_query_sqflite/src/adapter.dart';

class EducationLevelsDao extends MetaDao{

  EducationLevelsDao(SqfliteAdapter adapter) : super(adapter);

  @override
  String get tableName => 'EducationLevel';

}