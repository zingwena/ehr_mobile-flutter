

import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';
import 'MetaDao.dart';

class FamilyPlanningStatusDao extends MetaDao{

  FamilyPlanningStatusDao(SqfliteAdapter adapter) : super(adapter);

  @override
  String get tableName => 'FamilyPlanningStatus';

}
